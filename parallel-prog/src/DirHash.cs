using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

internal class Program
{
    public static byte[] CalcHash(FileStream stream)
    {
        using (var md5 = MD5.Create())
        {
            return md5.ComputeHash(stream);
        }
    }

    public static byte[] CalcDirHash(string dirPath)
    {
    /* Generate MD5 hashes of all files in directory and subdirectories.
       Combine these hash outputs into list, list into a larger byte array and MD5 hash that to produce an overall hash.
    */
            
        var paths = Directory.GetFiles(dirPath, "*", SearchOption.AllDirectories);
        Array.Sort(paths);

        List<Byte[]> hashes = new List<Byte[]>();

        using (var md5 = MD5.Create())
        {
            List<Task<byte[]>> tasks = new List<Task<byte[]>>();

            foreach (var path in paths)
            {
                var stream = File.OpenRead(path);
                Task<byte[]> task = Task<byte[]>.Run(() => CalcHash(stream));
                tasks.Add(task);
            }
                
            Task.WaitAll(tasks.ToArray());

            foreach (Task<byte[]> task in tasks)
            {
                hashes.Add((task.Result));
            }

            byte[] array = hashes.SelectMany(a => a).ToArray();

            return md5.ComputeHash(array);
        }
    }

    public static void Main(string[] args)
    {
        Console.WriteLine("Path to directory:");
        var path = Console.ReadLine();

        if (!Directory.Exists(path))
        {
            Console.WriteLine("No such directory!");
            return;
        }

        Stopwatch time1 = Stopwatch.StartNew();
        var hash = CalcDirHash(path);
        time1.Stop();

        Console.WriteLine("Time spent: {0}", time1.Elapsed);
        Console.WriteLine("Directory MD5 hash:");
        Console.WriteLine(BitConverter.ToString(hash).Replace("-", "").ToLower());
    }
}