using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

internal class Program
{
    public static List<int> CheckPrimeThreads(int beg, int end, int thrAmount)
    {
        int thrId = Thread.CurrentThread.ManagedThreadId;
        List<int> res = new List<int>();

        if (thrId < thrAmount)
        {
            int mid = (beg + end) / 2;

            List<int> res1 = new List<int>();
            List<int> res2 = new List<int>();

            Thread thr1 = new Thread(() => { res1.AddRange(CheckPrimeThreads(beg, mid, thrAmount)); });
            thr1.Start();

            Thread thr2 = new Thread(() => { res2.AddRange(CheckPrimeThreads(mid + 1, end, thrAmount)); });
            thr2.Start();

            thr1.Join();
            thr2.Join();

            res.AddRange(res1);
            res.AddRange(res2);
        }
        else
        {
            for (int i = beg; i <= end; i++)
            {
                if (IsPrime(i))
                {
                    res.Add(i);
                }
            }
        }

        return res;
    }

    public static List<int> CheckPrimeTasks(int beg, int end)
    {
        List<int> res = new List<int>();

        List<int> res1 = new List<int>();
        List<int> res2 = new List<int>();
        List<int> res3 = new List<int>();
        List<int> res4 = new List<int>();
        List<int> res5 = new List<int>();
        List<int> res6 = new List<int>();
        List<int> res7 = new List<int>();
        List<int> res8 = new List<int>();


        int eight = (end - beg) / 8;

        Task task1 = Task.Run(() => { res1.AddRange(IsPrimeInRange(beg, eight)); });
        Task task2 = Task.Run(() => { res2.AddRange(IsPrimeInRange(eight + 1, 2 * eight)); });
        Task task3 = Task.Run(() => { res3.AddRange(IsPrimeInRange(2 * eight + 1, 3 * eight)); });
        Task task4 = Task.Run(() => { res4.AddRange(IsPrimeInRange(3 * eight + 1, 4 * eight)); });
        Task task5 = Task.Run(() => { res5.AddRange(IsPrimeInRange(4*eight + 1, 5 * eight)); });
        Task task6 = Task.Run(() => { res6.AddRange(IsPrimeInRange(5*eight + 1, 6 * eight)); });
        Task task7 = Task.Run(() => { res7.AddRange(IsPrimeInRange(6 * eight + 1, 7 * eight)); });
        Task task8 = Task.Run(() => { res8.AddRange(IsPrimeInRange(7 * eight + 1, end)); });


        Task.WaitAll(task1, task2, task3, task4);

        res.AddRange(res1);
        res.AddRange(res2);
        res.AddRange(res3);
        res.AddRange(res4);
        res.AddRange(res5);
        res.AddRange(res6);
        res.AddRange(res7);
        res.AddRange(res8);

        return res;
    }

    public static List<int> CheckPrimeThreadPool(int beg, int end)
    {
        int[] data = new int[end];
        List<int> res = new List<int>();

        ManualResetEvent allDone = new ManualResetEvent(false);

        Wrapper wrapper = new Wrapper(allDone);

        ThreadPool.QueueUserWorkItem(_ => wrapper.CheckRangeCallback(data), data);
        allDone.WaitOne();

        for (int i = 0; i < data.Length; i++)
        {
            if (data[i] == 1)
            {
                res.Add(i);
            }
        }

        return res;
    }
        
    public static bool IsPrime(int num)
    {
        if (num == 1)
        {
            return false;
        }

        for (int i = 2; i <= Math.Sqrt(num); i++)
        {
            if (num % i == 0)
            {
                return false;
            }
        }

        return true;
    }

    private static List<int> IsPrimeInRange(int start, int finish)
    {
        List<int> result = new List<int>();

        for (int i = start; i < finish; i++)
        {
            if (IsPrime(i))
            {
                result.Add(i);
            }
        }

        return result;
    }

    class Wrapper
    {
        private ManualResetEvent _done;

        public Wrapper(ManualResetEvent done)
        {
            _done = done;
        }
            
        public void CheckRangeCallback(Object obj)
        {
            int[] range = (int[]) obj;
                
            for (int i = 0; i < range.Length; i++)
            {
                if (IsPrime(i))
                {
                    range[i] = 1;
                }
            }

            _done.Set();
        }    
        
        private static bool IsPrime(int n)
        {
            if (n % 2 == 0 && n != 2 || n == 1)
            {
                return false;
            }

            for (int i = 3; i <= Math.Round(Math.Sqrt(n)); i = i+2)
            {
                if (n % i == 0)
                {
                    return false;
                }
            }
            
            return true;
        }
    }
        
    public static void Main()
    {
        int start = 1;
        int end = 1000000;

        Console.WriteLine("Calculating prime numbers FROM 1 TO 1M...");

        for (int i = 0; i < 8; i++)
        {
            int thrAmount = (int) Math.Pow(2, i);
            
            Stopwatch time1 = Stopwatch.StartNew();
            List<int> nums1 = CheckPrimeThreads(start, end, thrAmount);
            time1.Stop();

            Console.WriteLine("Time on {0} threads: {1}", thrAmount, time1.Elapsed);
        }

        Console.WriteLine("----");
            
        Stopwatch time2 = Stopwatch.StartNew();
        List<int> nums2 = CheckPrimeTasks(start, end);
        time2.Stop();

        Console.WriteLine("Time on 8 tasks: {0}", time2.Elapsed);

        Console.WriteLine("----");
            
        Stopwatch time3 = Stopwatch.StartNew();
        List<int> nums3 = CheckPrimeThreadPool(start, end);
        time3.Stop();

        Console.WriteLine("Time on thread pool: {0}", time3.Elapsed);
    }
}