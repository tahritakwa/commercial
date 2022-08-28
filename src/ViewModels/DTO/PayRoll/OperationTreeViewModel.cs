using ViewModels.DTO.PayRoll.Lexer;

namespace ViewModels.DTO.PayRoll
{
    public class OperationTreeViewModel
    {
        public TokenViewModel Op { get; set; }
        public OperationTreeViewModel Left { get; set; }
        public OperationTreeViewModel Right { get; set; }

        public OperationTreeViewModel()
        {

        }

        public OperationTreeViewModel(TokenViewModel valeur)
        {
            Op = valeur;
            Left = null;
            Right = null;
        }

        public OperationTreeViewModel(OperationTreeViewModel left, TokenViewModel op, OperationTreeViewModel right)
        {
            Left = left;
            Op = op;
            Right = right;
        }

        public bool HasChild()
        {
            if (Left != null || Right != null)
            {
                return true;
            }
            return false;
        }
    }
}
