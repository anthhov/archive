/* This is implementation of The Bounded Single-Writer Algorithm for taking atomic snapshots of shared memory.
   The algorithm itself was taken from the article "Atomic Snapshots of Shared Memory" (http://people.csail.mit.edu/shanir/publications/AADGMS.pdf).
   There is an example for 2 registers.
*/

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;

class MainClass
{
    public class BSW
    {
        public struct Register
        {
            public int value;
            public bool[] p;
            public bool toggle;
            public int[] snapshot;
        }

        private readonly int REGCOUNT;

        private bool[,] q;
        private Register[] r;
        private Stopwatch time = Stopwatch.StartNew();

        public Dictionary<TimeSpan, int>[] logWrite;
        public Dictionary<TimeSpan, int[]> logRead = new Dictionary<TimeSpan, int[]>();

        public BSW(int regcount)
        {
            logWrite = new Dictionary<TimeSpan, int>[regcount];

            REGCOUNT = regcount;
            r = new Register[REGCOUNT];
            q = new bool[REGCOUNT, REGCOUNT];
            
            for (var i = 0; i < REGCOUNT; i++)
            {
                r[i].p = new bool[REGCOUNT];
                r[i].snapshot = new int[REGCOUNT];
                logWrite[i] = new Dictionary<TimeSpan, int>();
            }
        }

        public int[] Scan(int i, bool justForSnapshot)
        {
            var moved = new int[REGCOUNT];

            while (true)
            {
            
                for (var j = 0; j < REGCOUNT; j++)
                {
                    q[i, j] = r[j].p[i];
                }
    
                var a = (Register[])r.Clone();
                var b = (Register[])r.Clone();

                var condition = true;

                for (var j = 0; j < REGCOUNT; j++)
                {
                   
                    if (a[j].p[i] != q[i, j]
                        ||
                        b[j].p[i] != q[i, j]
                        ||
                        a[j].toggle != b[j].toggle)
                    {
                        if (moved[j] == 1)
                        {
                            if (!justForSnapshot) logRead.Add(time.Elapsed, b[j].snapshot);
                            return b[j].snapshot;
                        }

                        condition = false;
                        moved[j]++;
                    }
                }

                if (condition)
                {
                    var snapshot = new int[REGCOUNT];
                    for (var j = 0; j < REGCOUNT; j++)
                    {
                        snapshot[j] = b[j].value;
                    }

                    if (!justForSnapshot) logRead.Add(time.Elapsed, snapshot);
                    return snapshot;
                }
            }
        }

        public void Update(int i, int value)
        {
            var f = new bool[REGCOUNT];
            for (var j = 0; j < REGCOUNT; j++)
            {
                f[j] = !q[j, i];
            }

            var snapshot = Scan(i, true);
            
            r[i].value = value;
            r[i].p = f;
            r[i].toggle = !r[i].toggle;
            r[i].snapshot = snapshot;

            logWrite[i].Add(time.Elapsed, value);
        }
    }

    static void Main()
    {
        var bsw = new BSW(2);
        var random = new Random();
        var tasks = new Task[2];
        
        for (var i = 0; i < 20; i++)
        {
            var regNum = random.Next(10) % 2;
            var value = random.Next(100);

            tasks[regNum] = Task.Run(() =>
            {
                Console.WriteLine("write {0} in register #{1}", value, regNum);
                bsw.Update(regNum, value);
            });

            if (random.Next(100) % 3 == 0)
            {
                Task.Run(() =>
                {
                    Console.WriteLine("read from #{0} task: ", regNum, string.Join(", ", bsw.Scan(regNum, false)));
                });
            }

            if (i % 2 == 1)
            {
                Task.WaitAll(tasks);
            }
        }

        Console.WriteLine("----------------------------");

        for (var i = 0; i < 2; i++)
        {
            Console.WriteLine("register #{0} write-log:", i);
            
            foreach (var write in bsw.logWrite[i])
            {
                Console.WriteLine(write);
            }

            Console.WriteLine("----------------------------");
        }
        
        Console.WriteLine("read-log:");
        
        foreach (var read in bsw.logRead)
        {
            Console.Write("[{0}, ", read.Key);
            Console.WriteLine("(" + string.Join(", ", read.Value) + ")]");
        }
        
        Console.WriteLine("----------------------------");
    }
}