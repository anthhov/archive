using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace ParallelTree
{
    class Program
    {   
        static void Main()
        {
            int min = 0;
            int max = 100000;

            int[] keysToInsert = new int[1000000];
            int[] keysToDelete = new int[500000];
            int[] keysToFind = new int[1000000];

            Random randNum = new Random();
            
            for (int i = 0; i < keysToInsert.Length; i++)
            {
                keysToInsert[i] = randNum.Next(min, max);
            }
            
            for (int i = 0; i < keysToDelete.Length; i++)
            {
                int j = randNum.Next(min, max);
                keysToDelete[i] = keysToInsert[j];
            }
            
            for (int i = 0; i < keysToFind.Length; i++)
            {
                int j = randNum.Next(min, max);
                keysToFind[i] = keysToInsert[j];
            }

            var seqTree = new BinarySearchTree<int, char>();
            var parTree = new BinarySearchTree<int, char>();
            
            Stopwatch time1 = Stopwatch.StartNew();
           
            foreach (int key in keysToInsert)
            {
                seqTree.Insert(key, 'a');
            }
            
            time1.Stop();

            Console.WriteLine("Sequential insert: {0}", time1.Elapsed);
            
            if(!seqTree.IsBst(seqTree.Root))
                throw new Exception("Tree is incorrect after sequential insert!");
            
            Stopwatch time2 = Stopwatch.StartNew();
            
            foreach (int key in keysToDelete)
            {
                seqTree.Delete(key);
            }

            time2.Stop();

            Console.WriteLine("Sequential delete: {0}", time2.Elapsed);

            if(!seqTree.IsBst(seqTree.Root))
                throw new Exception("Tree is incorrect after sequential delete!");
                
            Stopwatch time3 = Stopwatch.StartNew();
            
            foreach (int key in keysToFind)
            {
                seqTree.Find(key);
            }

            time3.Stop();

            Console.WriteLine("Sequential search: {0}", time3.Elapsed);

            if(!seqTree.IsBst(seqTree.Root))
                throw new Exception("Tree is incorrect after sequential search!");
                   
            Stopwatch time4 = Stopwatch.StartNew();

            Parallel.ForEach (keysToInsert, key => {    
                parTree.Insert(key, 'a');
            });
            
            time4.Stop();

            Console.WriteLine("Concurrent insert: {0}", time4.Elapsed);

            if(!parTree.IsBst(parTree.Root))
                throw new Exception("Tree is incorrect after concurrent insert!");

            Stopwatch time5 = Stopwatch.StartNew();
            
            Parallel.ForEach (keysToDelete, key => {
                parTree.Delete(key);
            });
            
            time5.Stop();

            Console.WriteLine("Concurrent delete: {0}", time5.Elapsed);

            if(!parTree.IsBst(parTree.Root))
                throw new Exception("Tree is incorrect after concurrent delete!");
            
            Stopwatch time6 = Stopwatch.StartNew();
            
            Parallel.ForEach (keysToFind, key => {
                parTree.Find(key);
            });
            
            time6.Stop();

            Console.WriteLine("Concurrent search: {0}", time6.Elapsed);

            if(!parTree.IsBst(parTree.Root))
                throw new Exception("Tree is incorrect after concurrent search!");

        }
    }
}