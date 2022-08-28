using System;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity>
      where TModel : class
      where TEntity : class
    {

        public virtual void BeginTransaction()
        {
            _unitOfWork.BeginTransaction();
        }
        public void BeginTransactionunReadUncommitted()
        {
            _unitOfWork.BeginTransactionunReadUncommitted();
        }
        public void BeginTransactionunReadUncommitted(string connectionString)
        {
            _unitOfWork.BeginTransactionunReadUncommitted(connectionString);
        }
        public virtual void BeginTransaction(string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
        }
        public virtual void SetConnectionstring(string connectionString)
        {
            _unitOfWork.SetConnectionString(connectionString);
        }
        public virtual void EndTransaction()
        {
            _unitOfWork.CommitTransaction();
        }
        public virtual void RollBackTransaction()
        {
            _unitOfWork.RollbackTransaction();
        }

        public virtual void TryRollbackTransaction()
        {
            try
            {
                _unitOfWork.RollbackTransaction();
            }
            catch (Exception e)
            {
                throw e;
            }
        }


    }
}
