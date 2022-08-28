using System.Collections.Generic;
using ViewModels.DTO.PayRoll.Lexer;

namespace ViewModels.DTO.PayRoll
{
    public class SubTreeViewModel
    {
        public Queue<TokenViewModel> Op { get; set; }
        public SubTreeViewModel Left { get; set; }
        public SubTreeViewModel Right { get; set; }

        public SubTreeViewModel()
        {

        }

        public SubTreeViewModel(Queue<TokenViewModel> valeur)
        {
            Op = valeur;
            Left = null;
            Right = null;
        }

        public SubTreeViewModel(SubTreeViewModel left, Queue<TokenViewModel> op, SubTreeViewModel right)
        {
            Left = left;
            Op = op;
            Right = right;
        }

        public bool HasChild()
        {
            if (Left != null || Right != null)
                return true;
            return false;
        }
    }
}
