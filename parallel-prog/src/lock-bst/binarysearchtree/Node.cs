using System;
using System.Diagnostics;

namespace ParallelTree
{
    public class Node<TK, TV> where TK : IComparable<TK>
    {
        public TK Key;
        public TV Value;
        public Node<TK, TV> Parent;
        public Node<TK, TV> Left;
        public Node<TK, TV> Right;

        public Node(TK key, TV value, Node<TK, TV> parent)
        {
            Key = key;
            Value = value;
            Parent = parent;
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }
            
            Node<TK, TV> other = obj as Node<TK, TV>;

            Debug.Assert(other != null, nameof(other) + " != null");
            if (!Key.Equals(other.Key)) return false;
            if (!Value.Equals(other.Value)) return false;
            if (Parent != other.Parent) return false;
            if (Left != other.Left) return false;
            if (Right != other.Right) return false;

            return true;
        }
    }
}