using System;

namespace ParallelTree
{
    public interface ITree<TK, TV> where TK : IComparable<TK>
    {
        void Insert(TK key, TV value);

        void Delete(TK key);

        Tuple<TK, TV> Find(TK key);
    }
}