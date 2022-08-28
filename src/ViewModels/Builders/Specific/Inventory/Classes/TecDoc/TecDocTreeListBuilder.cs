using MySql.Data.MySqlClient;
using System.Collections.Generic;
using ViewModels.DTO.Inventory.TecDoc;

namespace ViewModels.Builders.Specific.Inventory.Classes.TecDoc
{
    public class TecDocTreeListBuilder
    {
        public List<TecDocProductListModelView> BuildList(MySqlDataReader reader)
        {
            List<TecDocProductListModelView> Products = new List<TecDocProductListModelView>();
            while (reader.Read())
            {
                Products.Add(new TecDocProductListModelView
                {
                    SearchTreeLevel = SafeGetInt(reader, 0),
                    RootId = SafeGetInt(reader, 2),
                    Node1Id = SafeGetInt(reader, 4),
                    Node2Id = SafeGetInt(reader, 6),
                    Node3Id = SafeGetInt(reader, 8),
                    RootName = SafeGetString(reader, 1),
                    Node1Name = SafeGetString(reader, 3),
                    Node2Name = SafeGetString(reader, 5),
                    Node3Name = SafeGetString(reader, 7),
                });
            }
            return Products;
        }

        public TecDocProductTreeViewModel LineToBranch(TecDocProductListModelView ProductLine)
        {
            TecDocProductTreeViewModel Branch = new TecDocProductTreeViewModel
            {
                NodeText = ProductLine.RootName,
                IdNode = ProductLine.RootId,
                IsRoot = true,
            };
            if (ProductLine.SearchTreeLevel > 1)
            {
                Branch.children = new List<TecDocProductTreeViewModel>
                {
                    new TecDocProductTreeViewModel
                    {
                        NodeText = ProductLine.Node1Name,
                        IdNode = ProductLine.Node1Id,
                    }
                };
                if (ProductLine.SearchTreeLevel > 2)
                {
                    Branch.children[0].children = new List<TecDocProductTreeViewModel>
                    {
                        new TecDocProductTreeViewModel
                        {
                            NodeText = ProductLine.Node2Name,
                            IdNode = ProductLine.Node2Id,
                        }
                    };
                    if (ProductLine.SearchTreeLevel > 3)
                    {
                        Branch.children[0].children[0].children = new List<TecDocProductTreeViewModel>
                        {
                            new TecDocProductTreeViewModel
                            {
                                NodeText = ProductLine.Node3Name,
                                IdNode = ProductLine.Node3Id,
                            }
                        };
                    }
                }

            }

            return Branch;
        }

        public List<TecDocProductTreeViewModel> BuildTree(List<TecDocApiTree> ProductList)
        {
            List<TecDocProductTreeViewModel> tree = new List<TecDocProductTreeViewModel>();
            ProductList.FindAll(x => x.ParentNodeId == 0).ForEach(node =>
            tree.Add(new TecDocProductTreeViewModel
            {
                IdNode = node.AssemblyGroupNodeId,
                IsRoot = true,
                NodeText =node.AssemblyGroupName,
                children = new List<TecDocProductTreeViewModel>()
            }));
                foreach (TecDocProductTreeViewModel child in tree)
                {
                    GetChildren(child, ProductList);
                }
            return tree;
        }

        private TecDocProductTreeViewModel GetChildren(TecDocProductTreeViewModel Node, List<TecDocApiTree> ProductList)
        {
            ProductList.FindAll(x => x.ParentNodeId == Node.IdNode).ForEach(y =>
              {
                  Node.children.Add(new TecDocProductTreeViewModel
                  {
                      IdNode = y.AssemblyGroupNodeId,
                      IsRoot = false,
                      NodeText = y.AssemblyGroupName,
                      children = new List<TecDocProductTreeViewModel>()
                  });
              });
            if (Node.children.Count !=0 ){
                foreach (TecDocProductTreeViewModel child in Node.children)
                {
                    GetChildren(child, ProductList);
                }
            }
            else
            {
                Node.children = null;
            }
            return Node;
        }

        public List<TecDocProductTreeViewModel> BuildTree(List<TecDocProductListModelView> ProductList)
        {
            List<TecDocProductTreeViewModel> Tree = new List<TecDocProductTreeViewModel>();
            TecDocProductListModelView Last = new TecDocProductListModelView();
            int lastrootindex = 0;
            int lastnode1index = 0;
            int lastnode2index = 0;
            foreach (TecDocProductListModelView product in ProductList)

            {
                if (Tree.Count == 0)
                    Tree.Add(LineToBranch(ProductList[0]));
                if (product.SearchTreeLevel == 1)
                {
                    Tree.Add(LineToBranch(product));

                }
                if (product.SearchTreeLevel == 2)
                {
                    if (product.RootId != Last.RootId)
                    {
                        Tree.Add(LineToBranch(product));

                    }
                    else
                    {
                        lastrootindex = Tree.Count - 1;
                        Tree[lastrootindex].children.Add(LineToBranch(product).children[0]);
                    }
                }

                if (product.SearchTreeLevel == 3)
                {
                    if (product.RootId != Last.RootId)
                    {
                        Tree.Add(LineToBranch(product));
                    }
                    else
                    {
                        lastrootindex = Tree.Count - 1;
                        if (product.Node1Id != Last.Node1Id)
                        {
                            Tree[lastrootindex].children.Add(LineToBranch(product).children[0]);
                        }
                        else
                        {
                            lastnode1index = Tree[lastrootindex].children.Count - 1;
                            Tree[lastrootindex].children[lastnode1index].children.Add(LineToBranch(product).children[0].children[0]);
                        }
                    }
                }

                if (product.SearchTreeLevel == 4)
                {

                    if (product.RootId != Last.RootId)
                    {
                        Tree.Add(LineToBranch(product));
                    }
                    else
                    {
                        lastrootindex = Tree.Count - 1;
                        if (product.Node1Id != Last.Node1Id)
                        {
                            Tree[lastrootindex].children.Add(LineToBranch(product).children[0]);
                        }
                        else
                        {
                            lastnode1index = Tree[lastrootindex].children.Count - 1;
                            if (product.Node2Id != Last.Node2Id)
                            {
                                Tree[lastrootindex].children[lastnode1index].children.Add(LineToBranch(product).children[0].children[0]);
                            }
                            else
                            {
                                lastnode2index = Tree[lastrootindex].children[lastnode1index].children.Count - 1;
                                Tree[lastrootindex].children[lastnode1index].children[lastnode2index].children.Add(LineToBranch(product).children[0].children[0].children[0]);
                            }
                        }
                    }
                }

                Last = product;
            }
            Tree.RemoveAt(0);
            return Tree;
        }

        public string SafeGetString(MySqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
                return reader.GetString(colIndex);
            return null;
        }
        public int SafeGetInt(MySqlDataReader reader, int colIndex)
        {
            if (!reader.IsDBNull(colIndex))
                return reader.GetInt32(colIndex);
            return 0;
        }
    }
}
