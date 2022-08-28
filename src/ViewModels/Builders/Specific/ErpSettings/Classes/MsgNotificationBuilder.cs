using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.Builders.Specific.ErpSettings.Classes
{
    public class MsgNotificationBuilder : GenericBuilder<MsgNotificationViewModel, MsgNotification>, IMsgNotificationBuilder
    {
        public IMessageBuilder _messageBuilder;

        public MsgNotificationBuilder(IMessageBuilder messageBuilder)
        {
            _messageBuilder = messageBuilder;
        }
        public override MsgNotificationViewModel BuildEntity(MsgNotification entity)
        {
            MsgNotificationViewModel model = base.BuildEntity(entity);
            model.IdMsgNavigation = _messageBuilder.BuildEntity(entity.IdMsgNavigation);
            return model;
        }
        public override MsgNotification BuildModel(MsgNotificationViewModel model)
        {
            MsgNotification entity = base.BuildModel(model);
            entity.IdMsgNavigation = _messageBuilder.BuildModel(model.IdMsgNavigation);
            return entity;
        }
    }
}
