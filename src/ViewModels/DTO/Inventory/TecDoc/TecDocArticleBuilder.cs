using System.Collections.Generic;
using System.Linq;
using Utils.Constants;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocArticleBuilder
    {
        public TecDocDetailsViewModel buildArticle(TecDocRowArticleDetails tecDocRowArticle)
        {
            return new TecDocDetailsViewModel
            {
                Id = tecDocRowArticle.GenericArticles[0].genericArticleId,
                Reference = tecDocRowArticle.ArticleNumber,
                ProductName = tecDocRowArticle.GenericArticles[0].genericArticleDescription,
                SupplierId = tecDocRowArticle.MfrId,
                SupplierBrand = tecDocRowArticle.MfrName,
                EanNumbers = tecDocRowArticle.Gtins.Count > 0 ? tecDocRowArticle.Gtins[0] : null
            };
        }

        public TecDocArticleViewModel buildArticleForGrid(TecDocRowArticleDetails tecDocRawArticle)
        {
            return new TecDocArticleViewModel
            {
                Id = tecDocRawArticle.GenericArticles[NumberConstant.Zero].legacyArticleId,
                Reference = tecDocRawArticle.ArticleNumber,
                Description = string.Join(" - ", tecDocRawArticle.GenericArticles.Select(x => x.genericArticleDescription).ToList()),
                IdSupplier = tecDocRawArticle.DataSupplierId,
                Supplier = tecDocRawArticle.MfrName,
                BarCode = tecDocRawArticle.Gtins.Count > NumberConstant.Zero ? tecDocRawArticle.Gtins[NumberConstant.Zero] : null,
                ImagesUrl = tecDocRawArticle.Images != null && tecDocRawArticle.Images.Count > NumberConstant.Zero ? tecDocRawArticle.Images[NumberConstant.Zero].imageURL800 : null,
                TecDocImageList = tecDocRawArticle.Images != null && tecDocRawArticle.Images.Count > NumberConstant.Zero ? tecDocRawArticle.Images.Select(x => x.imageURL800).ToList() : null,
                OemNumbers = tecDocRawArticle.OemNumbers != null && tecDocRawArticle.OemNumbers.Count > NumberConstant.Zero ? tecDocRawArticle.OemNumbers : null

            };
        }

        public List<List<int>> BuildCarIdArray(List<ArticleLinkage> CarLinkanges)
        {
            var Res = new List<List<int>>();
            for (int i = 0; i < CarLinkanges.Count(); i += 25)
            {
                List<int> list = CarLinkanges.Skip(i).Take(25).Select(x => x.linkingTargetId).ToList();
                Res.Add(list);
            }
            return Res;
        }
    }
}
