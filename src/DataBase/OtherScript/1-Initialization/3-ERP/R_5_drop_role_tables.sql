ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [DF_CheckBoxComponent_Checked];

GO
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [DF_ComboBoxComponent_globalization];

GO
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [DF_ComboBoxComponent_ng_required];

GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_autoSync];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSource_serverGrouping]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_serverGrouping];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSource_serverFiltering]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_serverFiltering];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSource_IsStaticDataSource]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_IsStaticDataSource];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSource_serverPaging]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_serverPaging];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSource_serverSorting]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_serverSorting];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSource_serverAggregates]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [DF_ComboBoxDataSource_serverAggregates];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxDataSourceItems_IdComboBoxDataSourceItems]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [DF_ComboBoxDataSourceItems_IdComboBoxDataSourceItems];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxOptions_autoBind]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [DF_ComboBoxOptions_autoBind];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxOptions_enable]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [DF_ComboBoxOptions_enable];


GO
PRINT N'Dropping [ERPSettings].[DF_ComboBoxOptions_height]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [DF_ComboBoxOptions_height];


GO
PRINT N'Dropping [ERPSettings].[DF_Component_classDiv]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [DF_Component_classDiv];


GO
PRINT N'Dropping [ERPSettings].[DF_Component_classComp]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [DF_Component_classComp];


GO
PRINT N'Dropping [ERPSettings].[DF_Component_IsEncapsulated]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [DF_Component_IsEncapsulated];


GO
PRINT N'Dropping [ERPSettings].[DF_Component_IsToInitialize]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [DF_Component_IsToInitialize];


GO
PRINT N'Dropping [ERPSettings].[DF_Component_IdComponent]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [DF_Component_IdComponent];


GO
PRINT N'Dropping [ERPSettings].[DF_Component_classLabel]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [DF_Component_classLabel];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListComponent_globalization]...';


GO
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [DF_DropDownListComponent_globalization];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListComponent_ng_required]...';


GO
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [DF_DropDownListComponent_ng_required];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListComponent_DropdownType]...';


GO
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [DF_DropDownListComponent_DropdownType];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListDataSource_serverGrouping]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [DF_DropDownListDataSource_serverGrouping];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListDataSource_serverPaging]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [DF_DropDownListDataSource_serverPaging];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListDataSource_autoSync]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [DF_DropDownListDataSource_autoSync];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListDataSource_serverSorting]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [DF_DropDownListDataSource_serverSorting];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListDataSource_serverAggregates]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [DF_DropDownListDataSource_serverAggregates];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListDataSource_serverFiltering]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [DF_DropDownListDataSource_serverFiltering];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListOptions_autoBind]...';


GO
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [DF_DropDownListOptions_autoBind];


GO
PRINT N'Dropping [ERPSettings].[DF_DropDownListOptions_enable]...';


GO
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [DF_DropDownListOptions_enable];


GO
PRINT N'Dropping [ERPSettings].[DF_Filter_IsDynamicValue]...';


GO
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [DF_Filter_IsDynamicValue];


GO
PRINT N'Dropping [ERPSettings].[DF_Filter_IsSearchPredicate]...';


GO
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [DF_Filter_IsSearchPredicate];


GO
PRINT N'Dropping [ERPSettings].[DF_Filter_IdFilter]...';


GO
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [DF_Filter_IdFilter];


GO
PRINT N'Dropping [ERPSettings].[DF_FonctionalityConfig_IdFunctionality]...';


GO
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [DF_FonctionalityConfig_IdFunctionality];


GO
PRINT N'Dropping [ERPSettings].[DF_FunctionnalityModule_IdFunctionnalityModule]...';


GO
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [DF_FunctionnalityModule_IdFunctionnalityModule];


GO
PRINT N'Dropping [ERPSettings].[DF_GridColumnComponent_groupHeaderTemplate]...';


GO
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [DF_GridColumnComponent_groupHeaderTemplate];


GO
PRINT N'Dropping [ERPSettings].[DF_GridColumnComponent_hidden]...';


GO
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [DF_GridColumnComponent_hidden];


GO
PRINT N'Dropping [ERPSettings].[DF_GridColumnComponent_editable]...';


GO
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [DF_GridColumnComponent_editable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridColumnComponent_nullable]...';


GO
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [DF_GridColumnComponent_nullable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridComponent_TreeType]...';


GO
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [DF_GridComponent_TreeType];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_serverFiltering]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_serverFiltering];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_batch]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_batch];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_serverAggregates]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_serverAggregates];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_serverSorting]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_serverSorting];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_serverPaging]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_serverPaging];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_pageSize]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_pageSize];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_serverGrouping]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_serverGrouping];


GO
PRINT N'Dropping [ERPSettings].[DF_GridDataSource_autoSync]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [DF_GridDataSource_autoSync];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_noRecords]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_noRecords];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_mobile]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_mobile];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_autoBind]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_autoBind];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_sortable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_sortable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_pageable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_pageable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_scrollable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_scrollable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_editable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_editable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_reorderable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_reorderable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_groupable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_groupable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_resizable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_resizable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_navigatable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_navigatable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_selectable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_selectable];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_columnMenu]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_columnMenu];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_allowCopy]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_allowCopy];


GO
PRINT N'Dropping [ERPSettings].[DF_GridOptions_filterable]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [DF_GridOptions_filterable];


GO
PRINT N'Dropping [ERPSettings].[DF_InputComponent_ng_required]...';


GO
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [DF_InputComponent_ng_required];


GO
PRINT N'Dropping [ERPSettings].[DF_Module_InMenuList]...';


GO
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [DF_Module_InMenuList];


GO
PRINT N'Dropping [ERPSettings].[DF_Module_IdModule]...';


GO
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [DF_Module_IdModule];


GO
PRINT N'Dropping unnamed constraint on [ERPSettings].[ModuleConfig]...';




GO
PRINT N'Dropping [ERPSettings].[DF_OrderBy_IdOrderBy]...';


GO
ALTER TABLE [ERPSettings].[OrderBy] DROP CONSTRAINT [DF_OrderBy_IdOrderBy];


GO
PRINT N'Dropping [ERPSettings].[DF_PredicateFormat_IdPredicateFormat]...';


GO
ALTER TABLE [ERPSettings].[PredicateFormat] DROP CONSTRAINT [DF_PredicateFormat_IdPredicateFormat];


GO
PRINT N'Dropping [ERPSettings].[DF_RadioButtonComponent_ng_required]...';


GO
ALTER TABLE [ERPSettings].[RadioButtonComponent] DROP CONSTRAINT [DF_RadioButtonComponent_ng_required];


GO
PRINT N'Dropping [ERPSettings].[DF_Relation_IdRelation]...';


GO
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [DF_Relation_IdRelation];


GO
PRINT N'Dropping [ERPSettings].[DF_ReportParameters_Id]...';


GO
ALTER TABLE [ERPSettings].[ReportParameters] DROP CONSTRAINT [DF_ReportParameters_Id];


GO
PRINT N'Dropping [ERPSettings].[DF_RoleInfo_IsDeleted]...';


GO
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [DF_RoleInfo_IsDeleted];


GO
PRINT N'Dropping [ERPSettings].[DF_ServiceParameters_IdServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [DF_ServiceParameters_IdServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_ComboBoxOptions_ComboBoxComponent]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxOptions] DROP CONSTRAINT [FK_ComboBoxOptions_ComboBoxComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_ComboBoxDataSourceItems_ComboBoxDataSource]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSourceItems] DROP CONSTRAINT [FK_ComboBoxDataSourceItems_ComboBoxDataSource];


GO
PRINT N'Dropping [ERPSettings].[FK_ComboBoxDataSource_ComboBoxOptions]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ComboBoxOptions];


GO
PRINT N'Dropping [ERPSettings].[FK_DropDownListComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[DropDownListComponent] DROP CONSTRAINT [FK_DropDownListComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_FieldSetComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[FieldSetComponent] DROP CONSTRAINT [FK_FieldSetComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_FormComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_GridButtonComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_GridColumnComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[GridColumnComponent] DROP CONSTRAINT [FK_GridColumnComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_GridComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[GridComponent] DROP CONSTRAINT [FK_GridComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ImageComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[ImageComponent] DROP CONSTRAINT [FK_ImageComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_InputComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[InputComponent] DROP CONSTRAINT [FK_InputComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_LabelComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[LabelComponent] DROP CONSTRAINT [FK_LabelComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_QrCodeComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_RadioButtonComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[RadioButtonComponent] DROP CONSTRAINT [FK_RadioButtonComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_RadioButtonComponentDetails_Component]...';


GO
ALTER TABLE [ERPSettings].[RadioButtonComponentDetails] DROP CONSTRAINT [FK_RadioButtonComponentDetails_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ReportViewerComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[ReportComponent] DROP CONSTRAINT [FK_ReportViewerComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ComponentToolbarComponent]...';


GO
ALTER TABLE [ERPSettings].[ToolBarComponent] DROP CONSTRAINT [FK_ComponentToolbarComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_BarCodeComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ButtonComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ComponentColumnMenu]...';


GO
ALTER TABLE [ERPSettings].[ColumnMenuComponent] DROP CONSTRAINT [FK_ComponentColumnMenu];


GO
PRINT N'Dropping [ERPSettings].[FK_CheckBoxComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[CheckBoxComponent] DROP CONSTRAINT [FK_CheckBoxComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ComboboxComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxComponent] DROP CONSTRAINT [FK_ComboboxComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_CheckBoxDetailsComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[CheckBoxComponentDetails] DROP CONSTRAINT [FK_CheckBoxDetailsComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_Component_Component]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_Component_Component1]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Component1];


GO
PRINT N'Dropping [ERPSettings].[FK_ComponentByRole_Component]...';


GO
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_ComponentByUser_Component]...';


GO
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_DialogComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[DialogComponent] DROP CONSTRAINT [FK_DialogComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_PopupComponent_Component]...';


GO
ALTER TABLE [ERPSettings].[PopupComponent] DROP CONSTRAINT [FK_PopupComponent_Component];


GO
PRINT N'Dropping [ERPSettings].[FK_DropDownListOptions_DropDownListComponent]...';


GO
ALTER TABLE [ERPSettings].[DropDownListOptions] DROP CONSTRAINT [FK_DropDownListOptions_DropDownListComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_DropDownListDataSource_DropDownListOptions]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_DropDownListOptions];


GO
PRINT N'Dropping [ERPSettings].[FK_GridOptions_GridComponent]...';


GO
ALTER TABLE [ERPSettings].[GridOptions] DROP CONSTRAINT [FK_GridOptions_GridComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_GridDataSource_GridOptions]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_GridOptions];


GO
PRINT N'Dropping [ERPSettings].[FK_QrCodeComponent_InputComponent]...';


GO
ALTER TABLE [ERPSettings].[QrCodeComponent] DROP CONSTRAINT [FK_QrCodeComponent_InputComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_InputDatePickerOptions_InputComponent]...';


GO
ALTER TABLE [ERPSettings].[InputDatePickerOptions] DROP CONSTRAINT [FK_InputDatePickerOptions_InputComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_BarCodeComponent_InputComponent]...';


GO
ALTER TABLE [ERPSettings].[BarCodeComponent] DROP CONSTRAINT [FK_BarCodeComponent_InputComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_FunctionnalityModule_Module]...';


GO
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module];


GO
PRINT N'Dropping [ERPSettings].[FK_ModuleConfig_Module]...';


GO
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module];


GO
PRINT N'Dropping [ERPSettings].[FK_Module_Module]...';


GO
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module];


GO
PRINT N'Dropping [ERPSettings].[FK_Filter_PredicateFormat]...';


GO
ALTER TABLE [ERPSettings].[Filter] DROP CONSTRAINT [FK_Filter_PredicateFormat];


GO
PRINT N'Dropping [ERPSettings].[FK_OrderBy_PredicateFormat]...';


GO
ALTER TABLE [ERPSettings].[OrderBy] DROP CONSTRAINT [FK_OrderBy_PredicateFormat];


GO
PRINT N'Dropping [ERPSettings].[FK_Relation_PredicateFormat]...';


GO
ALTER TABLE [ERPSettings].[Relation] DROP CONSTRAINT [FK_Relation_PredicateFormat];


GO
PRINT N'Dropping [ERPSettings].[FK_ServiceParameters_PredicateFormat]...';


GO
ALTER TABLE [ERPSettings].[ServiceParameters] DROP CONSTRAINT [FK_ServiceParameters_PredicateFormat];


GO
PRINT N'Dropping [ERPSettings].[FK_ReportViewerParameters_ReportViewerComponent]...';


GO
ALTER TABLE [ERPSettings].[ReportParameters] DROP CONSTRAINT [FK_ReportViewerParameters_ReportViewerComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_RoleConfigRole_Role]...';


GO
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_Role];


GO
PRINT N'Dropping [ERPSettings].[FK_Role_RoleInfo]...';


GO
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Role_RoleInfo];


GO
PRINT N'Dropping [ERPSettings].[FK_UserRole_Role]...';


GO
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_Role];


GO
PRINT N'Dropping [ERPSettings].[FK_ComponentByRole_Role]...';


GO
ALTER TABLE [ERPSettings].[ComponentByRole] DROP CONSTRAINT [FK_ComponentByRole_Role];


GO
PRINT N'Dropping [ERPSettings].[FK_RoleConfigRole_RoleConfig]...';


GO
ALTER TABLE [ERPSettings].[RoleConfigByRole] DROP CONSTRAINT [FK_RoleConfigRole_RoleConfig];


GO
PRINT N'Dropping [ERPSettings].[FK_FonctionalityConfig_RoleConfig]...';


GO
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig];


GO
PRINT N'Dropping [ERPSettings].[FK_ModuleConfig_RoleConfig]...';


GO
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig];


GO
PRINT N'Dropping [ERPSettings].[FK_RoleConfigCategory_RoleConfig]...';


GO
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig];


GO
PRINT N'Dropping [ERPSettings].[FK_DropDownListDataSource_ServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[DropDownListDataSource] DROP CONSTRAINT [FK_DropDownListDataSource_ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_FormComponent_ServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[FormComponent] DROP CONSTRAINT [FK_FormComponent_ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_GridButtonComponent_ServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[GridButtonComponent] DROP CONSTRAINT [FK_GridButtonComponent_ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_GridDataSource_ServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[GridDataSource] DROP CONSTRAINT [FK_GridDataSource_ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_ButtonComponent_ServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[ButtonComponent] DROP CONSTRAINT [FK_ButtonComponent_ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_ComboBoxDataSource_ServiceParameters]...';


GO
ALTER TABLE [ERPSettings].[ComboBoxDataSource] DROP CONSTRAINT [FK_ComboBoxDataSource_ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[FK_ToolBarOptionsToolbarComponent]...';


GO
ALTER TABLE [ERPSettings].[ToolBarOptions] DROP CONSTRAINT [FK_ToolBarOptionsToolbarComponent];


GO
PRINT N'Dropping [ERPSettings].[FK_ToolBarItemToolBarOptions]...';


GO
ALTER TABLE [ERPSettings].[ToolBarItem] DROP CONSTRAINT [FK_ToolBarItemToolBarOptions];


GO
PRINT N'Dropping [ERPSettings].[FK_Component_Functionality]...';


GO
ALTER TABLE [ERPSettings].[Component] DROP CONSTRAINT [FK_Component_Functionality];


GO
PRINT N'Dropping [ERPSettings].[FK_ComponentByUser_User]...';


GO
ALTER TABLE [ERPSettings].[ComponentByUser] DROP CONSTRAINT [FK_ComponentByUser_User];


GO
PRINT N'Dropping [ERPSettings].[FK_FonctionalityConfig_Functionality]...';


GO
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality];


GO
PRINT N'Dropping [ERPSettings].[FK_FunctionnalityModule_Functionality]...';


GO
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality];


GO
PRINT N'Dropping [ERPSettings].[FK_Information_RoleInfo]...';


GO
ALTER TABLE [ERPSettings].[RoleInfo] DROP CONSTRAINT [FK_Information_RoleInfo];


GO
PRINT N'Dropping [ERPSettings].[FK_UserRole_User]...';


GO
ALTER TABLE [ERPSettings].[UserRole] DROP CONSTRAINT [FK_UserRole_User];


GO
PRINT N'Dropping [ERPSettings].[BarCodeComponent]...';


GO
DROP TABLE [ERPSettings].[BarCodeComponent];


GO
PRINT N'Dropping [ERPSettings].[ButtonComponent]...';


GO
DROP TABLE [ERPSettings].[ButtonComponent];


GO
PRINT N'Dropping [ERPSettings].[CheckBoxComponent]...';


GO
DROP TABLE [ERPSettings].[CheckBoxComponent];


GO
PRINT N'Dropping [ERPSettings].[CheckBoxComponentDetails]...';


GO
DROP TABLE [ERPSettings].[CheckBoxComponentDetails];


GO
PRINT N'Dropping [ERPSettings].[ColumnMenuComponent]...';


GO
DROP TABLE [ERPSettings].[ColumnMenuComponent];


GO
PRINT N'Dropping [ERPSettings].[ComboBoxComponent]...';


GO
DROP TABLE [ERPSettings].[ComboBoxComponent];


GO
PRINT N'Dropping [ERPSettings].[ComboBoxDataSource]...';


GO
DROP TABLE [ERPSettings].[ComboBoxDataSource];


GO
PRINT N'Dropping [ERPSettings].[ComboBoxDataSourceItems]...';


GO
DROP TABLE [ERPSettings].[ComboBoxDataSourceItems];


GO
PRINT N'Dropping [ERPSettings].[ComboBoxOptions]...';


GO
DROP TABLE [ERPSettings].[ComboBoxOptions];


GO
PRINT N'Dropping [ERPSettings].[Component]...';


GO
DROP TABLE [ERPSettings].[Component];


GO
PRINT N'Dropping [ERPSettings].[ComponentByRole]...';


GO
DROP TABLE [ERPSettings].[ComponentByRole];


GO
PRINT N'Dropping [ERPSettings].[ComponentByUser]...';


GO
DROP TABLE [ERPSettings].[ComponentByUser];


GO
PRINT N'Dropping [ERPSettings].[DialogComponent]...';


GO
DROP TABLE [ERPSettings].[DialogComponent];


GO
PRINT N'Dropping [ERPSettings].[DropDownListComponent]...';


GO
DROP TABLE [ERPSettings].[DropDownListComponent];


GO
PRINT N'Dropping [ERPSettings].[DropDownListDataSource]...';


GO
DROP TABLE [ERPSettings].[DropDownListDataSource];


GO
PRINT N'Dropping [ERPSettings].[DropDownListOptions]...';


GO
DROP TABLE [ERPSettings].[DropDownListOptions];


GO
PRINT N'Dropping [ERPSettings].[FieldSetComponent]...';


GO
DROP TABLE [ERPSettings].[FieldSetComponent];


GO
PRINT N'Dropping [ERPSettings].[Filter]...';


GO
DROP TABLE [ERPSettings].[Filter];


GO
PRINT N'Dropping [ERPSettings].[FormComponent]...';


GO
DROP TABLE [ERPSettings].[FormComponent];


GO
PRINT N'Dropping [ERPSettings].[FunctionalityConfig]...';


GO
DROP TABLE [ERPSettings].[FunctionalityConfig];


GO
PRINT N'Dropping [ERPSettings].[FunctionnalityModule]...';


GO
DROP TABLE [ERPSettings].[FunctionnalityModule];


GO
PRINT N'Dropping [ERPSettings].[GridButtonComponent]...';


GO
DROP TABLE [ERPSettings].[GridButtonComponent];


GO
PRINT N'Dropping [ERPSettings].[GridColumnComponent]...';


GO
DROP TABLE [ERPSettings].[GridColumnComponent];


GO
PRINT N'Dropping [ERPSettings].[GridComponent]...';


GO
DROP TABLE [ERPSettings].[GridComponent];


GO
PRINT N'Dropping [ERPSettings].[GridDataSource]...';


GO
DROP TABLE [ERPSettings].[GridDataSource];


GO
PRINT N'Dropping [ERPSettings].[GridOptions]...';


GO
DROP TABLE [ERPSettings].[GridOptions];


GO
PRINT N'Dropping [ERPSettings].[ImageComponent]...';


GO
DROP TABLE [ERPSettings].[ImageComponent];


GO
PRINT N'Dropping [ERPSettings].[InputComponent]...';


GO
DROP TABLE [ERPSettings].[InputComponent];


GO
PRINT N'Dropping [ERPSettings].[InputDatePickerOptions]...';


GO
DROP TABLE [ERPSettings].[InputDatePickerOptions];


GO
PRINT N'Dropping [ERPSettings].[LabelComponent]...';


GO
DROP TABLE [ERPSettings].[LabelComponent];


GO
PRINT N'Dropping [ERPSettings].[Module]...';


GO
DROP TABLE [ERPSettings].[Module];


GO
PRINT N'Dropping [ERPSettings].[ModuleConfig]...';


GO
DROP TABLE [ERPSettings].[ModuleConfig];


GO
PRINT N'Dropping [ERPSettings].[OrderBy]...';


GO
DROP TABLE [ERPSettings].[OrderBy];


GO
PRINT N'Dropping [ERPSettings].[PopupComponent]...';


GO
DROP TABLE [ERPSettings].[PopupComponent];


GO
PRINT N'Dropping [ERPSettings].[PredicateFormat]...';


GO
DROP TABLE [ERPSettings].[PredicateFormat];


GO
PRINT N'Dropping [ERPSettings].[QrCodeComponent]...';


GO
DROP TABLE [ERPSettings].[QrCodeComponent];


GO
PRINT N'Dropping [ERPSettings].[RadioButtonComponent]...';


GO
DROP TABLE [ERPSettings].[RadioButtonComponent];


GO
PRINT N'Dropping [ERPSettings].[RadioButtonComponentDetails]...';


GO
DROP TABLE [ERPSettings].[RadioButtonComponentDetails];


GO
PRINT N'Dropping [ERPSettings].[Relation]...';


GO
DROP TABLE [ERPSettings].[Relation];


GO
PRINT N'Dropping [ERPSettings].[ReportComponent]...';


GO
DROP TABLE [ERPSettings].[ReportComponent];


GO
PRINT N'Dropping [ERPSettings].[ReportParameters]...';


GO
DROP TABLE [ERPSettings].[ReportParameters];


GO
PRINT N'Dropping [ERPSettings].[Role]...';


GO
DROP TABLE [ERPSettings].[Role];


GO
PRINT N'Dropping [ERPSettings].[RoleConfig]...';


GO
DROP TABLE [ERPSettings].[RoleConfig];


GO
PRINT N'Dropping [ERPSettings].[RoleConfigByRole]...';


GO
DROP TABLE [ERPSettings].[RoleConfigByRole];


GO
PRINT N'Dropping [ERPSettings].[RoleConfigCategory]...';


GO
DROP TABLE [ERPSettings].[RoleConfigCategory];


GO
PRINT N'Dropping [ERPSettings].[RoleInfo]...';


GO
DROP TABLE [ERPSettings].[RoleInfo];


GO
PRINT N'Dropping [ERPSettings].[ServiceParameters]...';


GO
DROP TABLE [ERPSettings].[ServiceParameters];


GO
PRINT N'Dropping [ERPSettings].[ToolBarComponent]...';


GO
DROP TABLE [ERPSettings].[ToolBarComponent];


GO
PRINT N'Dropping [ERPSettings].[ToolBarItem]...';


GO
DROP TABLE [ERPSettings].[ToolBarItem];


GO
PRINT N'Dropping [ERPSettings].[ToolBarOptions]...';


GO
DROP TABLE [ERPSettings].[ToolBarOptions];


GO
PRINT N'Dropping [ERPSettings].[UserRole]...';


GO
DROP TABLE [ERPSettings].[UserRole];


GO

-- Narcisse 11/08/2021 : Delete traceability table

GO
DROP TABLE [ERPSettings].[Traceability];
