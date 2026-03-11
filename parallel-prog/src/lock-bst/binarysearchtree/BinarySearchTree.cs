using System;

namespace ParallelTree
{
    public class BinarySearchTree<TK, TV> : ITree<TK, TV> where TK : IComparable<TK>
    {
        public Node<TK, TV> Root;

        public void Insert(TK key, TV value)
        {
            Node<TK, TV> father = null;

            var current = Root;

            while (current != null)
            {
                if (father == null)
                {
                    lock (current)
                    {
                        father = current;
                        
                        if (key.CompareTo(current.Key) < 0)
                            current = current.Left;
                        else if (key.CompareTo(current.Key) > 0)
                            current = current.Right;
                        else if (key.CompareTo(current.Key) == 0)
                        {
                            current.Value = value;
                            return;
                        }
                    }
                }
                else
                {
                    lock (father)
                    {
                        lock (current)
                        {
                            father = current;
                            if (key.CompareTo(current.Key) < 0)
                            {
                                current = current.Left;
                            }
                            else if (key.CompareTo(current.Key) > 0) current = current.Right;
                            else if (key.CompareTo(current.Key) == 0)
                            {
                                current.Value = value;
                                return;
                            }
                        }
                    }
                }
            }
            if (father == null)
            {
                Root = new Node<TK, TV>(key, value, null);
                return;
            }
            lock (father)
            {
                if (key.CompareTo(father.Key) < 0)
                {
                    father.Left = new Node<TK, TV>(key, value, father);
                }
                else
                {
                    father.Right = new Node<TK, TV>(key, value, father);
                }
            }
        }

        public Tuple<TK, TV> Find(TK key)
        {
            var result = FindNode(key);

            if (result == null)
                return null;

            return Tuple.Create(result.Key, result.Value);
        }

        private Node<TK, TV> FindNode(TK key)
        {
            var current = Root;

            while (current != null)
            {
                if (current.Parent == null)
                {
                    lock (current)
                    {
                        if (key.CompareTo(current.Key) == 0)
                            return current;
                        if (key.CompareTo(current.Key) < 0)
                            current = current.Left;
                        else
                            current = current.Right;
                    }
                }
                else
                {
                    lock (current.Parent)
                    {
                        lock (current)
                        {
                            if (key.CompareTo(current.Key) == 0)
                                return current;
                            if (key.CompareTo(current.Key) < 0)
                                current = current.Left;
                            else
                                current = current.Right;
                        }
                    }
                }
            }

            return null;
        }

        public void Delete(TK key)
        {
            var node = FindNode(key);

            if (node == null)
                return;

            if (node.Parent == null && node.Left == null && node.Right == null)
            {
                lock (node)
                {
                    Root = null;
                }
            }
            else if (node.Parent != null && node.Left == null && node.Right == null)
            {
                lock (node.Parent)
                {
                    lock (node)
                    {
                        if (node == node.Parent.Left)
                            node.Parent.Left = null;

                        if (node == node.Parent.Right)
                            node.Parent.Right = null;
                    }
                }
            }
            else if (node.Parent == null && node.Left == null && node.Right != null)
            {
                lock (node)
                {
                    node.Right.Parent = null;
                    Root = node.Right;
                }
            }
            else if (node.Parent == null && node.Right == null && node.Left != null)
            {
                lock (node)
                {
                    node.Left.Parent = null;
                    Root = node.Left;
                }
            }
            else if (node.Parent != null && (node.Right == null || node.Left == null))
            {
                lock (node.Parent)
                {
                    lock (node)
                    {
                        if (node.Right != null)
                        {
                            if (node.Parent.Left == node)
                            {
                                node.Right.Parent = node.Parent;
                                node.Parent.Left = node.Right;
                            }
                            else if (node.Parent.Right == node)
                            {
                                node.Right.Parent = node.Parent;
                                node.Parent.Right = node.Right;
                            }
                        }
                        else if (node.Left != null)
                        {
                            if (node.Parent.Left == node)
                            {
                                node.Left.Parent = node.Parent;
                                node.Parent.Left = node.Left;
                            }
                            else if (node.Parent.Right == node)
                            {
                                node.Left.Parent = node.Parent;
                                node.Parent.Right = node.Left;
                            }
                        }
                    }
                }
            }
            else
            {
                if (node.Parent != null)
                {
                    lock (node.Parent)
                    {
                        lock (node)
                        {
                            var successor = Min(node.Right);
                            node.Key = successor.Key;
                            
                            if (successor.Parent.Left == successor)
                            {
                                successor.Parent.Left = successor.Right;

                                if (successor.Right != null)
                                    successor.Right.Parent = successor.Parent;
                            }
                            else
                            {
                                successor.Parent.Right = successor.Right;

                                if (successor.Right != null)
                                    successor.Right.Parent = successor.Parent;
                            }
                        }
                    }
                }
                else if (node.Parent == null)
                {
                    lock (node)
                    {
                        var successor = Min(node.Right);
                        node.Key = successor.Key;

                        if (successor.Parent.Left == successor)
                        {
                            successor.Parent.Left = successor.Right;

                            if (successor.Right != null)
                                successor.Right.Parent = successor.Parent;
                        }
                        else
                        {
                            successor.Parent.Right = successor.Right;

                            if (successor.Right != null)
                                successor.Right.Parent = successor.Parent;
                        }
                    }
                }
            }
        }
        
        private Node<TK, TV> Min(Node<TK, TV> rootNode)
        {
            if (rootNode.Left == null)
                return rootNode;
            return Min(rootNode.Left);
        }
        
        public bool IsBst(Node<TK, TV> node) 
        {
            if (node == null)
            {
              return(true);
            }
            
            if (node.Left!=null){
                if((MaxValue(node.Left).CompareTo(node.Key)>0))
                    return false;      
            }

            if (node.Right != null)
            {
                if ((MinValue(node.Right).CompareTo(node.Key) < 0))
                    return false;
            }

            if (!IsBst(node.Left) || !IsBst(node.Right)) 
                return false;
           
            return true; 
        }

        private TK MaxValue(Node<TK, TV> node)
        {
            if (node.Right != null)
                return MaxValue(node.Right);
            
            return node.Key;
        }
        
        private TK MinValue(Node<TK, TV> node)
        {
            if (node.Left != null)
                return MaxValue(node.Left);
            
            return node.Key;
        }
    }
}