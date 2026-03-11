using System;

namespace ParallelTree
{
    public class Printer<TK, TV> where TK : IComparable<TK>
    {
        public void PrintTree(ITree<TK, TV> tree)
        {
            PrintNode(0, ((BinarySearchTree<TK, TV>) tree).Root);
        }

        private void PrintNode(int height, Node<TK, TV> node)
        {
            if (node == null)
                return;

            PrintNode(height + 1, node.Right);

            for (int i = 0; i < height; i++)
                Console.Write(" |");

           Console.WriteLine(node.Key + "" + node.Value);
           
           PrintNode(height + 1, node.Left);
        }
    }
}