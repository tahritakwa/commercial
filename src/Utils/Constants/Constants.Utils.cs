using System.Collections.Generic;
using System.IO;

namespace Utils.Constants
{
    public class Constants
    {
        #region stark
        /****************** Generic constants ***************************/
        public static readonly string SETTLEMENT_SETTLEMENTID = "SettlementId";
        public static readonly string COMMITMENT = "Commitment";
        public static readonly string COMMITMENT_RELATION_IDDOCUMENT = "Commitment.IdDocumentNavigation";
        public static readonly string COMMITMENT_RELATION_IDSTATUS = "Commitment.IdStatusNavigation";
        public static readonly string RELATION_IDDOCUMENT_IDTIERS = "IdDocumentNavigation.IdTiers";
        public static readonly string REMAINING_AMOUNT_WITH_CURRENCY = "RemainingAmountWithCurrency";
        public static readonly string ID_STATUS = "IdStatus";
        public static readonly string ID = "Id";
        public static readonly string UPDATE = "Update";

        /****************** Prices constants *****************/
        public static readonly string PURCHASED_QUANTITY = "PURCHASED_QUANTITY";
        public static readonly string TOTAL_PURCHASES = "TOTAL_PURCHASES";
        public static readonly string SPECIAL_PRICE = "COLLAPSE_SPECIAL_PRICE_DISCOUNT_TITLE";
        public static readonly string GIFTED_ITEMS = "COLLAPSE_GIFTED_ITEMS_DISCOUNT_TITLE";
        public static readonly int NUMBER_OF_ELEMENT_TO_SHOW = 2;

        /****************** ExcelUtility constants *****************/
        public static readonly string MATRICULE = "MATRICULE";
        public static readonly string MATRICULE_PASCAL_CASE = "Matricule";
        public static readonly string LINE = "LINE";
        public static readonly string VALUE = "VALUE";
        public static readonly string COLUMN = "COLUMN";
        public static readonly string ZERO = "0";
        public static readonly string NO = "no";
        public static readonly string NON = "non";
        public static readonly string FAUX = "faux";
        public static readonly string FALSE = "false";
        public static readonly string ONE = "1";
        public static readonly string YES = "yes";
        public static readonly string OUI = "oui";
        public static readonly string VRAI = "vrai";
        public static readonly string TRUE = "true";
        public static readonly int EXCEL_FIRST_DATA_LINE_NUMBER = 3;
        public static readonly string LINE_EXCEPTION = "line";

        /**************** Annotations constants *********************/
        public static readonly string REQUIRED_ATTRIBUTE = "RequiredAttribute";
        public static readonly string KEY_ATTRIBUTE = "KeyAttribute";
        public static readonly string EMAIL_ADDRESS_ATTRIBUTE = "EmailAddressAttribute";


        /**************** Dates constants *************************/
        public static readonly string SMALLEST_DATE = "SMALLEST_DATE";
        public static readonly string BIGGEST_DATE = "BIGGEST_DATE";
        public static readonly string SMALLEST_DATE_VALUE = "SMALLEST_DATE_VALUE";
        public static readonly string BIGGEST_DATE_VALUE = "BIGGEST_DATE_VALUE";
        public static readonly string BIRTH_DATE = "BIRTH_DATE";
        public static readonly string HIRING_DATE = "HIRING_DATE";
        public static readonly string START_DATE = "START_DATE";
        public static readonly string BASE_SALARY_START_DATE = "BASE_SALARY_START_DATE";
        public static readonly string CONTRACT_BONUS_START_DATE = "CONTRACT_BONUS_START_DATE";
        public static readonly string END_DATE = "END_DATE";
        public static readonly string ENTITY = "ENTITY";
        public static readonly string DATE = "DATE";

        /**************** Nature constants *************************/
        public static readonly string EXPENSE = "Expense";
        public static readonly string SERVICE = "Service";
        public static readonly string PRODUIT = "Produit";
        public static readonly string RESTAURN = "Ristourne";
        public static readonly string ADVANCE_PAYEMENT = "Avance";
        /**********************information types ***********************/
        public static readonly string SALES_DELIVERY_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE = "SALES_DELIVERY_AVAILABLE_PRODUCT_IN_CENTRAL_WAREHOUCE";
        public static readonly string SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE = "SALES_DELIVERY_AVAILABLE_PRODUCT_IN_WAREHOUCE";

        /***************** Item constants ***************************/
        public static readonly string RESERVED_QUANTITY_UPPER_CASE = "RESERVED_QUANTITY";
        public static readonly string RECEIVED_QUANTITY_UPPER_CASE = "RECEIVED_QUANTITY";
        public static readonly string UNITY_UPPER_CASE = "UNITY";
        public static readonly string ITEM_DESCRIPTION_UPPER_CASE = "ITEM_DESCRIPTION";

        /*************** Warehouse constants ******************/
        public static readonly string CENTRAL_WAREHOUSE_UPPER_CASE = "CENTRAL_WAREHOUSE";
        public static readonly string ITEM_IS_WAREHOUSE_UPPER_CASE = "ITEM_IS_WAREHOUSE";

        /************** Document constants ****************************/
        public static readonly string DOCUMENT_REFERENCE_UPPER_CASE = "DOCUMENT_REFERENCE";
        public static readonly string RECEPTION_DOCUMENT_REFERENCE_UPPER_CASE = "RECEPTION_DOCUMENT_REFERENCE";
        public static readonly string STATUS = "STATUS";

        /***************** Interview constants ***********************/
        public static readonly string CONFIRM_INTERVIEW_MARK = "CONFIRM_INTERVIEWMARK";
        public static readonly string ID_INTERVIEW = "IdInterview";
        public static readonly string INTERVIEW_MARK = "InterviewMark";
        public static readonly string INTERVIEW_CREATOR_UPPER_CASE = "INTERVIEW_CREATOR";
        public static readonly string INTERVIEW_DATE_UPPER_CASE = "INTERVIEW_DATE";
        public static readonly string INTERVIEW_TIME_UPPER_CASE = "INTERVIEW_TIME";
        public static readonly string ADDED_AS_REQUIRED_INTERVIEWER_FOR_CANDIDACY_UPPER_CASE = "ADDED_AS_REQUIRED_INTERVIEWER_FOR_CANDIDACY";
        public static readonly string ADDED_AS_OPTIONAL_INTERVIEWER_FOR_CANDIDACY_UPPER_CASE = "ADDED_AS_OPTIONAL_INTERVIEWER_FOR_CANDIDACY";
        public static readonly string DELETED_FROM_INTERVIEWER_LIST_FOR_CANDIDACY_UPPER_CASE = "DELETED_FROM_INTERVIEWER_LIST_FOR_CANDIDACY";
        public static readonly string ADDED_AS_REQUIRED_INTERVIEWER_FOR_REVIEW_UPPER_CASE = "ADDED_AS_REQUIRED_INTERVIEWER_FOR_REVIEW";
        public static readonly string ADDED_AS_OPTIONAL_INTERVIEWER_FOR_REVIEW_UPPER_CASE = "ADDED_AS_OPTIONAL_INTERVIEWER_FOR_REVIEW";
        public static readonly string DELETED_FROM_INTERVIEWER_FOR_REVIEW_LIST_UPPER_CASE = "DELETED_FROM_INTERVIEWER_LIST_FOR_REVIEW";
        public static readonly string ADDED_AS_REQUIRED_INTERVIEWER_FOR_EXIT_EMPLOYEE_UPPER_CASE = "ADDED_AS_REQUIRED_INTERVIEWER_FOR_EXIT_EMPLOYEE";
        public static readonly string ADDED_AS_OPTIONAL_INTERVIEWER_FOR_EXIT_EMPLOYEE_UPPER_CASE = "ADDED_AS_OPTIONAL_INTERVIEWER_FOR_EXIT_EMPLOYEE";
        public static readonly string DELETED_FROM_INTERVIEWER_FOR_EXIT_EMPLOYEE_LIST_UPPER_CASE = "DELETED_FROM_INTERVIEWER_LIST_FOR_EXIT_EMPLOYEE";
        public static readonly string NOTIFICATION_DATE_UPPER_CASE = "NOTIFICATION_DATE";
        public static readonly string USER_EMAIL_UPPER_CASE = "USER_EMAIL";
        public static readonly string FULL_RECRUITMENT = "FULL_RECRUITMENT";

        /***************** MobilityRequest constants ***********************/
        public static readonly string ADD_MOBILITY_REQUEST_UPPER_CASE = "ADD_MOBILITY_REQUEST";
        public static readonly string EMPLOYEE_FULLNAME = "EMPLOYEE_FULLNAME";
        public static readonly string CREATOR_FULLNAME = "CREATOR_FULLNAME";
        public static readonly string CURRENT_OFFICE_NAME = "CURRENT_OFFICE_NAME";
        public static readonly string DESTINATION_OFFICE_NAME = "DESTINATION_OFFICE_NAME";
        public static readonly string REQUEST_TIME = "REQUEST_TIME";

        /************* Email constants ************************/
        public static readonly string INTERVIEW_EMAIL_PATH_FR = Path.Combine("wwwroot", "views", "MallingTemplate", "InterviewMailTemplate-fr.html").Trim();
        public static readonly string INTERVIEW_EMAIL_PATH_EN = Path.Combine("wwwroot", "views", "MallingTemplate", "InterviewMailTemplate-en.html").Trim();
        public static readonly string SHARED_DOCUMENTS_PASSWORD_EMAIL_PATH_FR = Path.Combine("wwwroot", "views", "MallingTemplate", "SharedDocumentsPassword-fr.html").Trim();
        public static readonly string SHARED_DOCUMENTS_PASSWORD_EMAIL_PATH_EN = Path.Combine("wwwroot", "views", "MallingTemplate", "SharedDocumentsPassword-en.html").Trim();
        public static readonly string DO_NOT_REPLY_EMAIL = "donotreply@spark-it.fr";
        public static readonly string CONFIRMATION_EMAIL_PATH_FR = Path.Combine("wwwroot", "views", "MallingTemplate", "MailConfirmationPage-fr.html").Trim();
        public static readonly string CONFIRMATION_EMAIL_PATH_EN = Path.Combine("wwwroot", "views", "MallingTemplate", "MailConfirmationPage-en.html").Trim();

        /*************** Contract constants *******************/
        public static readonly string UPDATE_CONTRACT = "UPDATE_CONTRACT";
        public static readonly string SHOW_CONTRACT = "SHOW-Contract";
        public static readonly string SHOW_BONUS = "SHOW-Bonus";
        public static readonly string SHOW_BASE_SALARY = "LIST-BaseSalary";


        /*************** Shared constants *******************/
        public static readonly string SHARED_DOCUMENTS_KEY = "sharedDocumentsKey";
        public static readonly string DATE_FORMAT_INVARIANT_CULTURE = "dd/MM/yyyy";
        public static readonly string FULL_NAME = "FULL_NAME";
        public static readonly string EXPIRATION_DATE = "EXPIRATION_DATE";
        public static readonly string PROPERTY = "PROPERTY";
        public static readonly string Responsable_PAY = "Responsable_PAY";
        public static readonly string LANGUAGE = "LANGUAGE";
        public static readonly string NAME = "NAME";

        /************* SharedDocument constants ************************/
        public static readonly string SHARING_DOCUMENT = "SHARING_DOCUMENT";
        public static readonly string SHARING_PAYSLIP = "SHARING_PAYSLIP";
        public static readonly string SESSION_TITLE = "SESSION_TITLE";

        /************* TimeSheet constants ************************/
        public static readonly string TIMESHEET_VALIDATION_REQUEST = "TIMESHEET_VALIDATION_REQUEST";
        public static readonly string TIMESHEET_FILL_REQUEST = "TIMESHEET_FILL_REQUEST";
        public static readonly string TIMESHEET_SUBMISSION_REQUEST = "TIMESHEET_SUBMISSION_REQUEST";
        public static readonly string TIMESHEET_CORRECTION_REQUEST = "TIMESHEET_CORRECTION_REQUEST";

        /************* currency constants ************************/
        public static readonly string STYLE_CURRENCY = "currency";
        public static readonly string CURRENCY_DISPLAY_SYMBOL = "symbol";
        #endregion

        #region e-commerce
        /************* e-commerce log messages constants ************************/
        public static readonly string ECOMMERCE_BADGATEWAY_ERROR_MSG = "Le serveur e-commerce a rencontré une erreur temporaire.";
        public static readonly string ECOMMERCE_IN_PROGRESS_EXCEPTION_MSG = "Une requête de e-commerce est en cours.";
        public static readonly string LIBERATION_QTE_EXCEPTION_MSG = "La libération de la quantité d'un produit est impossible.";
        public static readonly string ACCESS_DENIED = "L'utilisateur n'est pas autorisé à faire cette action.";
        public static readonly string BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS = "Début: Synchronisation des détails des produits sélectionnés avec e-commerce.";
        public static readonly string END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS = "Fin : Synchronisation des détails des produits sélectionnés avec e-commerce.";
        public static readonly string PREPARING_PRODUCTS_TO_SYNCHRONIZE = "Préparation des produits pour la synchronisation avec e-commerce.";
        public static readonly string SENDING_PRODUCTS_TO_SYNCHRONIZE = "Envoi des produits pour la synchronisation avec e-commerce.";
        public static readonly string RECEIVING_ECOMMERCE_RESPONSE = "Réception de la réponse de e-commerce.";
        public static readonly string UPDATING_SYNCHRONIZATION_STATUS = "Mise à jour du statut de synchronisation des produits synchronisés.";
        public static readonly string SUCCESS_SYNCHRONIZATION = "Synchronisation réussie avec e-commerce pour le produit de référence : ";
        public static readonly string SUCCESS_UPDATE_STARK = "Mise à jour avec succès dans Stark pour le produit de référence : ";
        public static readonly string ERROR_SYNCHRONIZATION = "Erreur de synchronisation avec e-commerce pour les produits de référence : ";
        public static readonly string ERROR_SYNCHRONIZATION_MESSAGE = " avec le message : ";


        public static readonly string BEGIN_SYNCHRONIZE_IS_ECOMMERCE = "Début : Synchronisation de la colonne IsEcommerce de produits avec e-commerce.";
        public static readonly string END_SYNCHRONIZE_IS_ECOMMERCE = "End : Synchronisation de la colonne IsEcommerce de produits avec e-commerce.";
        public static readonly string SUCCESS_SYNCHRONIZATION_IS_ECOMMERC = "Succès de la synchronisation de colonne IsEcommerce " +
            "avec e-commerce pour les produits des Ids : ";
        public static readonly string ERROR_SYNCHRONIZATION_IS_ECOMMERCE = "Erreur de la synchronisation de colonne IsEcommerce " +
            "avec e-commerce pour les produits des Ids : ";
        public static readonly string WAITING_SYNCHRONIZATION_IS_ECOMMERCE = "Enregistrement du status En attente de la synchronisation de " +
            "la colonne IsEcommerce pour les produits mises en ligne pour la première fois";


        public static readonly string BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB = "Début: Synchronisation des détails des produits avec e-commerce sans attendre le Job.";
        public static readonly string END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB = "Fin : Synchronisation des détails des produits avec e-commerce sans attendre le Job.";

        public static readonly string BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_FROM_JOB = "Début: Synchronisation des détails des produits avec e-commerce en utilisant le Job.";
        public static readonly string END_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_FROM_JOB = "Fin : Synchronisation des détails des produits avec e-commerce en utilisant le Job.";

        public static readonly string BEGIN_GENRATE_DELEVERY_FORMS_FROM_JOB = "Début: Génération des bon de livraisons stark depuis e-commerce.";
        public static readonly string END_GENRATE_DELEVERY_FORMS_FROM_JOB = "Fin : Génération des bons de livraisons stark depuis e-commerce.";
        public static readonly string SENDING_GETTING_DELEVERY_FORMS_REQUEST_FROM_JOB = "Envoi de la demande de récupération des bons de livraisons depuis e-commerce.";

        public static readonly string BEGIN_CREATING_DELEVERY_FORM_FROM_JOB = "Début : Creation dans stark du bon de livraison id e-commerce : ";
        public static readonly string END_CREATING_DELEVERY_FORM_FROM_JOB = "Fin : Creation dans stark du bon de livraison id e-commerce : ";
        public static readonly string ALREADY_EXIST_DELEVERY_FORM_FROM_JOB = "Bon de livraison existe déja dans stark id e-commerce : ";
        public static readonly string ADD_CONFIRMATION_DELEVERY_FORM_FROM_JOB = "Ajout de la confirmation de l'existance du bon de livraions dans stark, id e-commerce : ";
        public static readonly string ERROR_CREATING_DELEVERY_FORM_FROM_JOB = "Erreur de création du bon de livraions dans stark, id e-commerce : ";
        public static readonly string SENDING_DELEVERY_FORMS_LIST_FROM_JOB = "Envoi de la liste des bons de livraisons ajouter avec succées dans stark.";
        public static readonly string ERROR_GENRATE_DELEVERY_FORMS_FROM_JOB = "Erreur dans la génération des bon de livraisons stark depuis e-commerce";

        /************* files names ************************/
        public static readonly string ECOMMERCE_LOG_FILE_NAME = "e-commerce_log";
        public static readonly string ECOMMERCE_SYNCHRONIZE_FILE_NAME = "e-commerce_Synchronize_log";
        public static readonly string ECOMMERCE_NOT_SYNCHRONIZE_FILE_NAME = "e-commerce_Not_Synchronized_log";
        public static readonly string ECOMMERCE_RESPONSE_FROM_MAGENTO = "e-commerce_Response_From_Magento";
        public static readonly string LOGIN_LOG_FILE_NAME = "login_log";
        public static readonly string LOGOUT_LOG_FILE_NAME = "logout_log";
        public static readonly string HAS_PERMISSION_FILE_NAME = "has_permission_log";
        #endregion
        public static readonly string CORRECTION_REQUEST_TIMESHEET = "CORRECTION_REQUEST_TIMESHEET";
        public static readonly string VALIDATION_TIMESHEET = "VALIDATION_TIMESHEET";
        public static readonly string SUBMISSION_TIMESHEET = "SUBMISSION_TIMESHEET";

        /************* Leave constants ************************/
        public static readonly string LEAVE_REQUEST = "LEAVE_REQUEST";
        public static readonly string ADD_LEAVE_REQUEST = "ADD_LEAVE_REQUEST";
        public static readonly string UPDATE_LEAVE_REQUEST = "UPDATE_LEAVE_REQUEST";
        public static readonly string DELETE_LEAVE_REQUEST = "DELETE_LEAVE_REQUEST";
        public static readonly string VALIDATE_LEAVE_REQUEST = "VALIDATE_LEAVE_REQUEST";
        public static readonly string REFUSE_LEAVE_REQUEST = "REFUSE_LEAVE_REQUEST";
        public static readonly string CANCEL_LEAVE_REQUEST = "CANCEL_LEAVE_REQUEST";
        public static readonly string UPDATING = "UPDATING";
        public static readonly string ADDING = "ADDING";
        public static readonly string DELETION = "DELETION";
        public static readonly string VALIDATION = "VALIDATION";
        public static readonly string REJECTION = "REJECTION";
        public static readonly string CANCELLATION = "CANCELLATION";
        public static readonly string WITH_TEAM_MEMBERS = "WithTeamMembers";

        /************* Document request constants ************************/
        public static readonly string ADD_DOCUMENT_REQUEST = "ADD_DOCUMENT_REQUEST";
        public static readonly string UPDATE_DOCUMENT_REQUEST = "UPDATE_DOCUMENT_REQUEST";
        public static readonly string VALIDATE_DOCUMENT_REQUEST = "VALIDATE_DOCUMENT_REQUEST";
        public static readonly string REFUSE_DOCUMENT_REQUEST = "REFUSE_DOCUMENT_REQUEST";
        public static readonly string DELETE_DOCUMENT_REQUEST = "DELETE_DOCUMENT_REQUEST";
        /************* Chat constants ************************/
        public static readonly string USER_MAIL = "userMail";
        public static readonly string LIST_UNCONNECTED_USER = "ListUnConnectedUser";
        public static readonly string LIST_CONNECTED_USER = "ListConnectedUser";
        public static readonly string RECEIVE_MESSAGE = "ReceiveMessage";
        public static readonly string RECEIVE_SEEN_MESSAGE_EVENT = "ReceiveSeenMessageEvent";
        public static readonly string RECEIVE_ADD_MEMBERS_EVENT = "ReceiveAddMembersEvent";
        public static readonly string RECEIVE_NEW_DISCUSSION_NAME = "ReceiveNewDiscussionName";
        public static readonly string RECEIVE_NEW_GROUP_MEMBERS = "ReceiveNewGroupMembers";

        /************* Dashboard constants ************************/
        public static readonly string TOP_TIERS_KPI = "[Reporting].[GetKPITopTiers]";
        public static readonly string CARTES_KPI = "[Reporting].[GetCartes]";
        public static readonly string SALES_PER_ITEM_KPI = "[Reporting].[GetKPISalesPerItem]";
        public static readonly string SALES_PURCHASE_STATE_KPI = "[Reporting].[GetKPISalesPurchaseState]";
        public static readonly string RANK_CRITERIA_AMOUNT = "Amnt";
        public static readonly string RANK_CRITERIA_QUANTITY = "Qty";
        public static readonly string PARAMETER_PERIOD = "@Period";
        public static readonly string PARAMETER_MONTH = "@Month";
        public static readonly string PARAMETER_YEAR = "@Year";
        public static readonly string PARAMETER_DAY = "@Day";
        public static readonly string PARAMETER_OPERATION_TYPE = "@OperationType";
        public static readonly string PARAMETER_RANK_CRITERIA = "@RankCriteria";
        public static readonly string PARAMETER_NUMBER_OF_ROWS = "@NumberOfRows";
        public static readonly string PARAMETER_TEAM_NAME = "@TeamName";
        public static readonly string PARAMETER_LABEL = "@Label";
        public static readonly string PARAMETER_BY_MONTH = "@ByMonth";
        public static readonly string PARAMETER_ID_TIER = "@IdTier";
        public static readonly string SALE_OPERATION_TYPE = "SA";
        public static readonly string PURCHASE_OPERATION_TYPE = "PU";
        public static readonly string SALES_TURNOVER_MONTH_LABEL = "Last Month Turnover,Current Month Turnover";
        public static readonly string PURCHASE_TURNOVER_MONTH_LABEL = "Last Month Depense,Current Month Depense";
        public static readonly string CUSTOMER_LABEL = "TotalClient";



        /************* Employee constants ************************/
        public static readonly string EMPLOYEE_DOCUMENT_LABEL = "EMPLOYEE_DOCUMENT_LABEL";
        public static readonly string SUPERIOR_EMPLOYEE_NAME = "SUPERIOR_EMPLOYEE_NAME";
        public static readonly string INFERIOR_EMPLOYEE_NAME = "INFERIOR_EMPLOYEE_NAME";
        public static readonly string UPDATE_EMPLOYEE = "UPDATE-Employee";
        public static readonly string RIB = "Rib";
        public static readonly string SSN = "SocialSecurityNumber";
        public static readonly string CHILDREN_NUMBER = "ChildrenNumber";
        public static readonly string PARENT_IN_CHARGE = "ParentInCharge";
        public static readonly string CHILDREN_DISABLED = "ChildrenDisabled";
        public static readonly string CHILDREN_NO_SCHOLAR = "ChildrenNoScholar";
        public static readonly string WORKING_TIME = "WorkingTime";
        public static readonly string MAX_VALUE = "MAX_VALUE";
        /************* User constants ************************/
        public static readonly string ADD_NEW_USER = "ADD_NEW_USER";
        public static readonly string NEW_USER = "NEW_USER";
        public static readonly string LIST_PURCHASEPRICEHISTORY = "LIST-PURCHASEPRICEHISTORY";

        /************* Login constants ************************/
        public static readonly string FAILED = "Failed";
        public static readonly string UNAUTHORIZED_SOCIETY = "UNAUTHORIZED_SOCIETY";
        public static readonly string SUCCESS = "Success";
        public static readonly string ROLES = "roles";
        public static readonly string ROLE_CONFIGS = "RoleConfigs";
        public static readonly string CONNECTION_STRING = "connectionString";
        public static readonly string BAD_REQUEST = "Bad Request";
        public static readonly string CREDENTIALS = "credentials";
        public static readonly string REDUCED_ROLE_CONFIGS_MODULES_FUNCS = "ReducedRoleConfigsModulesFuncs";
        public static readonly string IS_SUPER_ADMIN = "isSuperadmin";
        public static readonly string PASSWORD_SETTINGS = "Password_settings";

        /************* Annual interview constants ************************/
        public static readonly string ANNUAL_REVIEW = "ANNUAL_REVIEW";
        public static readonly string REVIEW_DATE_UPPER_CASE = "REVIEW_DATE_UPPER_CASE";
        public static readonly string SUPERIOR_LEVEL = "SuperiorLevel";
        /************* Employee Exit constants ************************/
        public static readonly string MATERIAL_RECOVERY = "MATERIAL_RECOVERY";
        /************* Bad reference ************************/
        public static readonly string BAD_REFERENCE = "BAD_REFERENCE";
        public static readonly string FORMALISM_VALUE = "FORMALISM_VALUE";

        /************* Privilege references ************************/
        public static readonly string EMPLOYEE = "EMPLOYEE";
        public static readonly string PAY = "PAY";
        public static readonly string CONTRACT = "CONTRACT";
        public static readonly string JOB = "JOB";

        /***** Treso *****/
        public static readonly string DOCUMENT_CODE = "DOCUMENT_CODE";
        public static readonly string WITHHOLDING_TAX = "WITHHOLDING_TAX";

        /************* Language constants ************************/
        public static readonly string French = "fr";
        public static readonly string English = "en";

        /************* special characters constants ************************/
        public static readonly string Underscore = "_";
        public static readonly string REFERENCE = "REFERENCE";

        /************* expense report constants ************************/
        public static readonly string ADD_EXPENSE_REPORT = "ADD_EXPENSE_REPORT";
        public static readonly string UPDATE_EXPENSE_REPORT = "UPDATE_EXPENSE_REPORT";
        public static readonly string VALIDATE_EXPENSE_REPORT = "VALIDATE_EXPENSE_REPORT";
        public static readonly string REFUSE_EXPENSE_REPORT = "REFUSE_EXPENSE_REPORT";
        public static readonly string DELETE_EXPENSE_REPORT = "DELETE_EXPENSE_REPORT";
        public static readonly string DOC_CREATOR = "DOC_CREATOR";
        public static readonly string DOC_CODE = "DOC_CODE";
        public static readonly string PROFIL = "PROFIL";

        /************* Files extensions ************************/
        public static readonly string PDF = "pdf";
        public static readonly string PNG = "png";
        public static readonly string JPG = "jpg";
        public static readonly string DOCX = "docx";
        public static readonly string DOC = "doc";
        public static readonly string JPEG = "jpeg";
        public static readonly string REPORT_D_PU = "report_D-PU";
        public static readonly string PURCHASE_DELIV_EXP_REPORT = "purchasedelivexpreport";
        public static readonly string PURCHASE_DELIV_REPORT = "purchasedeliveryreport";
        public static readonly string PURCHASE_DELIV_COST_REPORT = "purchasedelivcostreport";
        public static readonly string PURCHASE_REPORT = "Rapport de pointage";
        public static readonly string PURCHASE_EXPENSE_REPORT = "Rapport des charges";
        public static readonly string PURCHASE_COST_REPORT = "Rapport des prix de revient";

        /************* authentication ********************/
        public static readonly string TOKEN = "token";
        public static readonly string PERMISSIONS = "permissions";
        public static readonly string ENVURL = "envUrl";

        /************* permission ************************/
        public static readonly string LIST_BONUS = "LIST_BONUS";


        /************* base link ************************/
        public static readonly string PAYROLL_LINK = "/payroll";
        public static readonly string RH_LINK = "/rh";
        /************* Listes roles ************************/
        public static readonly List<string> rolesRh = new List<string>{ "Responsable_PAY", "EXPENSE_REPORT", "Consultant", "Cra", "Leave_config", "Manager" , "Exit_employee",
        "ANNUAL_INTERVIEWS", "Contrat-Full", "Document", "G_administrative_RW", "Responsable_RH", "Session_Paie", "Recrutement_Request"};
        public static readonly List<string> rolesCommercial = new List<string>{ "Accounting_Settings", "Comptabilite", "BS_Config", "BL_Config",
        "Facture_config", "Avoir_Config" , "PurchaseInvoice_Config", "Client_Config", "DocumentControl_Config", "SalesInvoiceAsset_Config", "SalesFinancialAsset_Config"};

        /************* Inventory constants ************************/
        public static readonly string OEM_NUMBER = "OEM_NUMBER";
        public static readonly string BRAND = "BRAND";
        public static readonly string OEM = "OEM";

    }
}