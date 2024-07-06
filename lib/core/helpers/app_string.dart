String getLanguageCode(String language) {
  switch (language) {
    case 'العربية':
      return 'ar';
    default:
      return 'en';
  }
}

class AppString {
  // Home Screen
  static const String totalBalance = 'Total Balance';
  static const String income = 'Income';
  static const String expense = 'Expense';
  static const String recent = 'Recent';
  static const String seeAll = 'See All';
  static const String deletedTransactionMessage =
      'Transaction deleted successfully';
  static const String emptyExpenseMessage =
      'There are no expenses, \n try to log new expense';
  static const String emptyIncomeMessage =
      'There are no incomes, \n try to log new income';

  // Add Transaction Screen
  static const String newTransaction = 'New Transaction';
  static const String editTransaction = 'Edit Transaction';
  static const String title = 'Title';
  static const String titleExample = 'e.g. Shopping, Salary, etc.';
  static const String amount = 'Amount';
  static const String date = 'Date';
  static const String noteOptional = 'Note (Optional)';
  static const String noteExample = 'To be remembered';
  static const String attachmentOptional = 'Attachment (Optional)';
  static const String addAttachment = 'Add Attachment (Image, PDF, etc.)';
  static const String removeAttachment = 'Remove Attachment';
  static const String saveTransaction = 'Save Transaction';
  static const String saveChanges = 'Save Changes';

  // Transaction Detail Screen
  static const String transactionDetails = 'Transaction Details';
  static const String note = 'Note';
  static const String noNote = 'No Note';
  static const String attachment = 'Attachment';
  static const String noAttachment = 'No Attachment';
  static const String openAttachment = 'Open Attachment';
  static const String type = 'Type';
  static const String deleteTransaction = 'Delete Transaction';
  static const String deleteTransactionMessage =
      'Are you sure about deleting this transaction?';

  // All Transaction Screen
  static const String transactions = 'Transactions';
  static const String noTransactions =
      'There are no transactions, \n try to log new transaction';
  static const String addNewTransaction = 'Add New Transaction';
  static const String lowToHigh = 'Low to High';
  static const String highToLow = 'High to Low';
  static const String oldToNew = 'Old to New';
  static const String newToOld = 'New to Old';
  static const String byCategory = 'By Category';

  // Statistics Screen
  static const String financialReports = 'Financial Reports';
  static const String categoriesPercentage = 'Categories Percentage';
  static const String historyOverview = 'History Overview';
  static const String today = 'Today';
  static const String lastWeek = 'Last Week';
  static const String lastMonth = 'Last Month';

  // Categories Screen
  static const String categories = 'Categories';
  static const String newCustomCategory = 'New Custom Category';
  static const String categoryName = 'Category Name';
  static const String categoryNameExample = 'e.g. Shopping, Food, etc.';
  static const String addCategory = 'Add Category';
  static const String deleteCategory = 'Delete Category';
  static const String deleteCategoryMessage =
      'All transactions belong to this category will be deleted, Are you sure about deleting this category?';
  static const String categoryColor = 'Category Color';

  // Settings Screen
  static const String settings = 'Settings';
  static const String resetPIN = 'Reset PIN';
  static const String preferences = 'Preferences';

  // Reset PIN Screen
  static const String enterYourCurrentPIN = 'Enter your current PIN';
  static const String enterNewPIN = 'Enter new PIN';
  static const String reEnterYourNewPIN = 'Re-enter your new PIN';
  static const String passwordResetedSuccessfully =
      'Password reseted successfully';

  // Preferences Screen
  static const String language = 'Language';
  static const String languageDescription = 'Choose your native language';
  static const String dateFormat = 'Date Format';
  static const String dateFormatDescription = 'Choose prefered date format';
  static const String daysAgo = 'D days ago';
  static const String dMYFormat = 'DD/MM/YYYY';
  static const String currency = 'Currency';
  static const String custom = "Custom";
  static const String currencyDescription = 'Enter your country currency';

  // Error Messages
  static const String error = 'Error';
  static const String incompletePIN = 'PIN must be 4 digits';
  static const String incorrectPIN = 'Incorrect PIN';
  static const String pinNotMatch = 'PIN does not match';
  static const String enterTitle = 'Please enter title';
  static const String enterAmount = 'Please enter amount';
  static const String enterDate = 'Please enter date';
  static const String numericalAmountError = 'Amount must be numerical';
  static const String invalidDateError =
      'Invalid Date, Please enter a valid date or pick a corrected date directly';

  // Actions
  static const String edit = 'Edit';
  static const String next = 'Next';
  static const String undo = 'Undo';
  static const String confirm = 'Confirm';
  static const String done = 'Done';
  static const String gotIt = 'Got it';
  static const String delete = 'Delete';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String yes = 'Yes';
  static const String no = 'No';
}
