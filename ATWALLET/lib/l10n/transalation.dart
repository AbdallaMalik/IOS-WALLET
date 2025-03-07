import 'package:flutter/material.dart';
import 'package:wallet_cryptomask/config.dart';
import 'package:wallet_cryptomask/core/providers/locale_provider/locale_provider.dart';

class Translations {
  final Map<String, dynamic> _localizedValues;

  Translations(this._localizedValues);

  String get(String key) {
    return _localizedValues[key] ?? key;
  }

  static Translations of(dynamic context) {
    String locale = getLocalProvider(context).locale;

    Map<String, dynamic> translations = loadTranslations(locale);

    return Translations(translations);
  }

  static Map<String, dynamic> loadTranslations(String locale) {
    return loadTranslationsFromJson(locale);
  }

  static Map<String, dynamic> loadTranslationsFromJson(String locale) {
    if (locale == 'en') {
      return en;
    }
    if (locale == "fr") {
      return fr;
    } else {
      return en;
    }
  }
}

var en = {
  "appName": appName,
  "importAccount": "Import Account",
  "addressCopied": "Public address copied to clipboard",
  "success": "Success",
  'confirmation': "Confirmation",
  "contact": "Contact",
  "irreversible": " This action is irreversible",
  "eraseWarning":
      "This action will erase all previous wallets and all funds will be lost. Make sure you can restore with your saved 12 word secret phrase and private keys for each wallet before you erase!.",
  "eraseAndContinue": "Erase and continue",
  'createWallet': "Create Wallet",
  'noRecent': "No recent transaction",
  "to": "To",
  "from": "From",
  "seedphrase": "Seedphrase",
  "accepTermsWarning":
      "You must to accept the terms and condition to use {appName}",
  "passwordConfirmPasswordNotMatch": "Password and confirm password not mached",
  "getStarted": "Get Started",
  "currentLanguage": "Current language",
  "welcomeTo": "Welcome to $appName",
  "explorerFeature": "Explore Features",
  "trustedByMillion": "Trused by Million",
  "safeReliableSuperfast": "Safe, Reliable and Superfast",
  "securityYouCan": "Security You Can Trust",
  "template1":
      "Manage, store, and trade your digital assets securely and effortlessly. Let's get started!",
  "template2":
      "Discover DApp with our DApp browser, transaction history, and more to enhance your crypto experience.",
  "template3":
      "Experience unparalleled security with our on-device storage. Your private keys and sensitive data are stored directly on your device, ensuring that only you have access.",
  "walletSetup": "Wallet setup",
  "importAnExistingWalletOrCreate":
      "Import an existing wallet or create a new one",
  "importUsingSecretRecoveryPhrase": "Import using Secret Recovery Phrase",
  "createANewWallet": "Create a new wallet",
  "secretRecoveryPhrase": "Secret Recovery Phrase",
  "password": "Password",
  "importWallet": "Import Wallet",
  "buy": "Buy",
  "insufficientFund": "Insufficient fund",
  "passPhraseNotEmpty": "Passpharse shouldn't be empty",
  "passwordNotEmpty": "Passwored shouldn't be empty",
  "youDontHaveToken": "You don't have any token for this chain",
  "enterYourSecretRecoveryPharse": "Enter your Secret Recovery Phrase",
  "enterNewPassword": "Enter new password",
  "secureWallet": "Secure wallet",
  "createPassword": "Create password",
  "yourAccountDeactivated":
      "Your account was deactivated, Please contact admin for more details",
  "createWalletGreet": "Great!, Wallet created successfully",
  "contactAdmin": "Contact admin",
  "backUp": "Backup now",
  "adminBlockYourTransaction":
      "You're restricted to make transactions please contact admin for more info",
  "youHaventBackedup": "You haven't backup the Secret Recovery Phrase",
  "confirmSeed": "Confirm seed",
  "thisPasswordWill":
      "This password will unlock your wallet only on this device.",
  "newPassword": "New password",
  "show": "Show",
  "confirmPassword": "Confirm password",
  "mustBeAtleast": "Must be atleast 8 character",
  "passwordMustContain": "Password must contain atleast 8 characters",
  "viewOnExplorer": "View on Explorer",
  "failedToEstimated":
      "Failed to estimate gas fee. Estimated manually, Transaction may fail.",
  "iUnserstandTheRecover":
      "I understand the {appName} cannot recover this password for me.",
  "@iUnserstandTheRecover": {
    "description": "Greet the user by their name.",
    "placeholders": {
      "appName": {"type": "String"}
    }
  },
  "welcomeBack": "Welcome Back!",
  "confirmAndApprove": "Confirm and Approve",
  "resetWallet": "Reset Wallet",
  "passwordShouldntBeEmpy": "Password shouldn't be empty",
  "next": "Next",
  "passwordIncorrect": "Password incorrect, provider valid password",
  "cantLogin":
      "Can't login due to lost password? You can reset current wallet and restore with your saved secret 12 word phrase",
  "thisFieldNotEmpty": "This filed shouldn't be empty",
  "writeSecretRecoveryPhrase": "Write down your Secret Recovery Phrase",
  "yourSecretRecoveryPhrase":
      "This is your Secret RecoveryPhrase. Write it down on a paper and keep it in a safe place. You'll be asked to re-enter this phrase (in order) on the next step",
  "tapToReveal": "Tap to reveal you Secret Recovery Phrase",
  "makeSureNoOneWatching": "Make sure no one is watching your screen",
  "continueT": "Continue",
  "selectEachWord": "Select each word in the order it was presented to you",
  "reset": "Reset",
  "view": "View",
  "receive": "Receive",
  "send": "Send",
  "swap": "Swap",
  "deleteWallet": "Delete Wallet",
  "tokens": "Tokens",
  "collectibles": "Collectibles",
  "dontSeeYouToken": "Don't see your tokens?",
  "importTokens": "Import Tokens",
  "scanAddressto": "Scan adress to receive payment",
  "copy": "Copy",
  "requestPayment": "Request Payment",
  "dontSeeYouCollectible": "Don't see your NFTs?",
  "importCollectible": "Import NFT",
  "importTokensLowerCase": "Import tokens",
  "search": "Search",
  "customTokens": "Custom Token",
  "thisFeatureInMainnet": "This feature only available on mainnet",
  "anyoneCanCreate":
      "Anyone can create a token, including creating fake versions of existing tokens. Learn more about scams and security risks",
  "tokenAddress": "Token address",
  "tokenSymbol": "Token symbol",
  "tokenDecimal": "Token Decimal",
  "cancel": "Cancel",
  "import": "Import",
  "top20Token": "Top ERC20 token",
  "importToken": "Import token",
  "tokenAddedSuccesfully": "Token added successfully",
  "collectibleAddedSuccesfully": "Collectible added successfully",
  "tokenName": "Token name",
  "tokenID": "Token ID",
  "clearBrowserStorage": "Clear browser storage",
  "nftOwnedSomeone":
      "NFT is owned by someone, You can only import NFT that you owned",
  "nftDeleted": "NFT deleted successfully",
  "youHaveNoTransaction": "You have not transaction",
  "searchPublicAddress": "Search public address (0x), or ENS",
  "transferBetweenMy": "Transfer between my accounts",
  "recent": "Recent",
  "balance": "Balance",
  "back": "Back",
  "useMax": "Use MAX",
  "amount": "Amount",
  "likelyIn30Second": "Likely in < 30 seconds",
  "likelyIn15Second": "Likely in 15 seconds",
  "mayBeIn30Second": "Maybe in 30 seconds",
  "estimatedGasFee": "Estimated gas fee",
  "total": "Total",
  "maxFee": "Max fee",
  "maxAmount": "Max amount",
  "transactionFailed": "Transaction failed",
  "transactionSubmitted": "Transaction submitted",
  "waitingForConfirmation": "Waiting for confirmation",
  "editPriority": "Edit priority",
  "low": "Low",
  "medium": "Market",
  "high": "High",
  "advanceOptions": "Advance options",
  "howShouldIChoose": "How should I choose",
  "gasLimit": "Gas limit",
  "maxPriorityGwei": "Max priority fee (GWEI)",
  "maxFeeSwei": "Max fee (GWEI)",
  "confirmTrasaction": "Confirm transaction",
  "selectTokenToSwap": "Select Token to swap",
  "selectaToken": "Select a token",
  "getQuotes": "Get quotes",
  "convertFrom": "Convert from",
  "convertTo": "Convert to",
  "enterTokenName": "Enter token name",
  "newQuoteIn": "New quote in",
  "availableToSwap": "available to swap",
  "swipeToSwap": "Swipe to swap",
  "wallet": "Wallet",
  "transactionHistory": "Transaction History",
  "viewOnEtherscan": "View on Explorer",
  "shareMyPubliAdd": "Share my Public Address",
  "settings": "Settings",
  "getHelp": "Get Help",
  "logout": "Logout",
  "explorer": "Explorer",
  "general": "General",
  "generalDescription":
      "Currency conversion, primary currency, language and search engine",
  "networks": "Networks",
  "networksDescription": "Add and edit custom RPC networks",
  "contacts": "Contacts",
  "contactDescription": "Add, edit, remove and manage you accounts",
  "about": "About {appName}",
  "@about": {
    "description": "about",
    "placeholders": {
      "appName": {"type": "String"}
    }
  },
  "currencyConversion": "Currency conversion",
  "displayFiat":
      "Display fiat values in using a specific currency throughout the application",
  "languageDescription":
      "Translate the application to a different supported language",
  "createNewAccount": "Create New Account",
  "security": "Security",
  "securityDescription": "Manage privatekey and export wallet",
  "showPrivateKey": "Show private key (Tap to copy)",
  "tapHereToReveal": "Tap and hold to reveal and copy private key",
  "exportWallet": "Export wallet",
  "tapHereToExportWallet":
      "Tap and hold to export wallet (Your current password is used for import)",
  "browser": "Browser",
  "learnMore": "Learn more",
  "securityNotePK":
      "You will be asked to enter password to view your Privatekey",
  "showSeedphrase": "Show Secret recovery phrase (Tap to copy)",
  "securityNoteSD":
      "You will be asked to enter password to view your Secret recovery phrase",
  "privateKeyCopiedToClipboard": "Private key copied to clipboard",
  "SRPCoipied": "Secret recovery phrase copied to clipboard",
  "unkownContact": "Unknown address",
  "somethingWentWrong": "Something went wrong",
  "rejectConfirmation": "Reject Cofirmation",
  "rejectRequestConfirmation": "Are you surely want to reject this request ?",
  "no": "No",
  "dappIsRequesting": "This Dapp",
  "ethSign": "Eth Sign",
  "signData": "Sign Data",
  "approve": "Approve",
  "reject": "Reject",
  "signMessage": "Sign Message",
  "personalSign": "Personal sign",
  "invalidInput": "Invalid input",
  "invalidAmount": 'The value cannot have more than {} decimal places.',
  "fileSendAdminDialog": "Do yo want to send a file to admin?",
  "sortBy": "Sort by ",
  "addContact": "Add Contact",
  "updateContact": "Update Contact",
  'notEmpty': "not empty",
  "name": "Name",
  "invalid": "Invalid",
  "publicAddressNotEmpty": "Public address shouldn't be empty",
  "invalidAddress": "Invalid Address",
  "publicAddress": "Public address",
  "deleteWarning": "Are you surely want to delete this contact?",
  "dappBrowser": "Dapp Browser",
  "error": "Error",
  "privateKey": "Privatekey",
  "enterPrivateKey": "Enter privatekey",
  "privateKeyNotEmpty": "Privakey shouldn't be empty",
  "passwordAtleast": "Password atleast contain 8 character",
  "openWallet": 'Open Wallet',
  'scanQrCode': "Scan QR Code",
  "walletConnect": "WalletConnect",
  "manageWCSession": 'Manage WalletConnect session',
  'contactUs': "Contact Us",
  "sendMessage": 'Send a message to us',
  "viewFullHistory": "View full history on Explorer",
  "noTransaction": "You have no transactions!",
  "txSubmitted": "Transaction with {txHash} is sumbitted to the network",
  "transactionFailed1": "Transaction failed",
  "transactionFailedMessage": "Transaction is failed sumbit to the network",
  "confirmTransaction": "Confirm transaction",
  "platformFee": 'Platform fee',
  "status": "Status",
  "confirmed": "Confirmed",
  "copyTxId": "Copy Tranaction ID",
  "transaction": "Transaction",
  "myContacts": 'My Contacts',
  "myAccount": 'My Accounts',
  "wcSessions": 'WalletConnect Sessions',
  "wcEndDialog": 'Do you want to end session with all dapps?',
  "endAll": "End all",
  "endOne": 'Do you want to end session with {name}?',
  "end": "End",
  "noWC": "No WalletConnect session found",
  "isRequesting": "is requesting a transaction",
  "estimateGas": "Estimated gas fee",
  "siteSuggested": "Site suggested",
  "amountWithFee": "Amount + gas fee",
  "connectToThis": "Connect to this site?",
  "byClicking":
      "By clicking connect, you allow this dapp to view your public address. This is an important security step to protect your data from potential phishing risks.",
  "chainsAreRequried": "chains requested",
  "newTab": "New tab",
  "createNewTab": "Create new Tab",
  "searchOrType": "Search or type a web address",
  "copied": "Copied",
  "pkCopied": "Privatekey copied to clipboard",
  "addCopied": "Public address copied to clipboard",
  "passwordIsInvalid": "Passwod is invalid, Please try again",
  "updateAvailable": "Update available",
  "availableVersions": "Available version",
  "newVersions": "New version of {appName} is available on App Store.",
  "currentVersion": 'Current version: ',
  "improvePerformance": "Improved performance and stability.",
  "couldNot": 'Could not launch',
  'somethingWentWrongInitial':
      "Something went wrong, Please check your internet connect",
  "retry": "Retry"
};

var fr = {
  "appName": appName,
  "importAccount": "Importer un compte",
  "addressCopied": "Adresse publique copiée dans le presse-papiers",
  "success": "Succès",
  "confirmation": "Confirmation",
  "contact": "Contact",
  "irreversible": "Cette action est irréversible",
  "eraseWarning":
      "Cette action effacera tous les portefeuilles précédents et tous les fonds seront perdus. Assurez-vous de pouvoir restaurer avec votre phrase secrète de 12 mots et les clés privées de chaque portefeuille avant d'effacer!",
  "eraseAndContinue": "Effacer et continuer",
  "createWallet": "Créer un portefeuille",
  "noRecent": "Aucune transaction récente",
  "to": "À",
  "from": "De",
  "accepTermsWarning":
      "Vous devez accepter les termes et conditions pour utiliser {appName}",
  "passwordConfirmPasswordNotMatch":
      "Le mot de passe et la confirmation du mot de passe ne correspondent pas",
  "getStarted": "Commencer",
  "currentLanguage": "Langue actuelle",
  "welcomeTo": "Bienvenue sur {appName}",
  "explorerFeature": "Explorer les fonctionnalités",
  "trustedByMillion": "Digne de confiance par des millions",
  "safeReliableSuperfast": "Sûr, fiable et ultra-rapide",
  "securityYouCan": "Sécurité à laquelle vous pouvez faire confiance",
  "template1":
      "Gérez, stockez et échangez vos actifs numériques en toute sécurité et sans effort. Allons-y!",
  "template2":
      "Découvrez les DApps avec notre navigateur DApp, l'historique des transactions et plus encore pour améliorer votre expérience crypto.",
  "template3":
      "Profitez d'une sécurité inégalée avec notre stockage sur l'appareil. Vos clés privées et vos données sensibles sont stockées directement sur votre appareil, garantissant que vous seul y avez accès.",
  "walletSetup": "Configuration du portefeuille",
  "importAnExistingWalletOrCreate":
      "Importer un portefeuille existant ou en créer un nouveau",
  "importUsingSecretRecoveryPhrase":
      "Importer en utilisant la phrase secrète de récupération",
  "createANewWallet": "Créer un nouveau portefeuille",
  "secretRecoveryPhrase": "Phrase secrète de récupération",
  "password": "Mot de passe",
  "importWallet": "Importer un portefeuille",
  "buy": "Acheter",
  "insufficientFund": "Fonds insuffisants",
  "clearBrowserStorage": "Effacer le stockage du navigateur",
  "passPhraseNotEmpty": "La phrase secrète ne doit pas être vide",
  "passwordNotEmpty": "Le mot de passe ne doit pas être vide",
  "youDontHaveToken": "Vous n'avez aucun jeton pour cette chaîne",
  "enterYourSecretRecoveryPharse":
      "Entrez votre phrase secrète de récupération",
  "enterNewPassword": "Entrez un nouveau mot de passe",
  "secureWallet": "Sécuriser le portefeuille",
  "createPassword": "Créer un mot de passe",
  "yourAccountDeactivated":
      "Votre compte a été désactivé, veuillez contacter l'administrateur pour plus de détails",
  "createWalletGreet": "Super ! Portefeuille créé avec succès",
  "contactAdmin": "Contacter l'administrateur",
  "backUp": "Sauvegarder maintenant",
  "adminBlockYourTransaction":
      "Vous êtes restreint pour effectuer des transactions, veuillez contacter l'administrateur pour plus d'informations",
  "youHaventBackedup":
      "Vous n'avez pas sauvegardé la phrase secrète de récupération",
  "confirmSeed": "Confirmer la phrase secrète",
  "thisPasswordWill":
      "Ce mot de passe déverrouillera votre portefeuille uniquement sur cet appareil.",
  "newPassword": "Nouveau mot de passe",
  "show": "Montrer",
  "confirmPassword": "Confirmer le mot de passe",
  "mustBeAtleast": "Doit contenir au moins 8 caractères",
  "passwordMustContain": "Le mot de passe doit contenir au moins 8 caractères",
  "viewOnExplorer": "Voir sur l'explorateur",
  "failedToEstimated":
      "Échec de l'estimation des frais de gaz. Estimation manuelle, la transaction peut échouer.",
  "iUnserstandTheRecover":
      "Je comprends que {appName} ne peut pas récupérer ce mot de passe pour moi.",
  "@iUnserstandTheRecover": {
    "description": "Saluer l'utilisateur par son nom.",
    "placeholders": {
      "appName": {"type": "String"}
    }
  },
  "welcomeBack": "Bon retour!",
  "confirmAndApprove": "Confirmer et approuver",
  "resetWallet": "Réinitialiser le portefeuille",
  "passwordShouldntBeEmpy": "Le mot de passe ne doit pas être vide",
  "next": "Suivant",
  "passwordIncorrect":
      "Mot de passe incorrect, fournissez un mot de passe valide",
  "cantLogin":
      "Impossible de se connecter à cause d'un mot de passe perdu? Vous pouvez réinitialiser le portefeuille actuel et le restaurer avec votre phrase secrète de 12 mots sauvegardée",
  "thisFieldNotEmpty": "Ce champ ne doit pas être vide",
  "writeSecretRecoveryPhrase": "Notez votre phrase secrète de récupération",
  "yourSecretRecoveryPhrase":
      "Ceci est votre phrase secrète de récupération. Notez-la sur un papier et gardez-la dans un endroit sûr. Vous serez invité à ressaisir cette phrase (dans l'ordre) à l'étape suivante",
  "tapToReveal": "Appuyez pour révéler votre phrase secrète de récupération",
  "makeSureNoOneWatching": "Assurez-vous que personne ne regarde votre écran",
  "continueT": "Continuer",
  "selectEachWord":
      "Sélectionnez chaque mot dans l'ordre dans lequel il vous a été présenté",
  "reset": "Réinitialiser",
  "view": "Voir",
  "receive": "Recevoir",
  "send": "Envoyer",
  "swap": "Échanger",
  "deleteWallet": "Supprimer le portefeuille",
  "tokens": "Jetons",
  "collectibles": "Objets de collection",
  "dontSeeYouToken": "Vous ne voyez pas vos jetons?",
  "importTokens": "Importer des jetons",
  "scanAddressto": "Scannez l'adresse pour recevoir le paiement",
  "copy": "Copier",
  "requestPayment": "Demander un paiement",
  "dontSeeYouCollectible": "Vous ne voyez pas vos NFT?",
  "importCollectible": "Importer un NFT",
  "importTokensLowerCase": "importer des jetons",
  "search": "Rechercher",
  "customTokens": "Jeton personnalisé",
  "thisFeatureInMainnet":
      "Cette fonctionnalité est uniquement disponible sur le mainnet",
  "anyoneCanCreate":
      "N'importe qui peut créer un jeton, y compris des versions fausses de jetons existants. En savoir plus sur les escroqueries et les risques de sécurité",
  "tokenAddress": "Adresse du jeton",
  "tokenSymbol": "Symbole du jeton",
  "tokenDecimal": "Décimal du jeton",
  "cancel": "Annuler",
  "import": "Importer",
  "top20Token": "Top 20 des jetons ERC20",
  "importToken": "Importer un jeton",
  "tokenAddedSuccesfully": "Jeton ajouté avec succès",
  "collectibleAddedSuccesfully": "Objet de collection ajouté avec succès",
  "tokenName": "Nom du jeton",
  "tokenID": "ID du jeton",
  "nftOwnedSomeone":
      "Le NFT est possédé par quelqu'un d'autre, vous ne pouvez importer que des NFT que vous possédez",
  "nftDeleted": "NFT supprimé avec succès",
  "youHaveNoTransaction": "Vous n'avez aucune transaction",
  "searchPublicAddress": "Rechercher une adresse publique (0x), ou ENS",
  "transferBetweenMy": "Transfert entre mes comptes",
  "recent": "Récent",
  "balance": "Solde",
  "back": "Retour",
  "useMax": "Utiliser le MAX",
  "amount": "Montant",
  "likelyIn30Second": "Probablement en < 30 secondes",
  "likelyIn15Second": "Probablement en 15 secondes",
  "mayBeIn30Second": "Peut-être en 30 secondes",
  "estimatedGasFee": "Frais de gaz estimés",
  "total": "Total",
  "maxFee": "Frais max",
  "maxAmount": "Montant max",
  "transactionFailed": "Transaction échouée",
  "transactionSubmitted": "Transaction soumise",
  "waitingForConfirmation": "En attente de confirmation",
  "editPriority": "Modifier la priorité",
  "low": "Faible",
  "medium": "Marché",
  "high": "Élevé",
  "advanceOptions": "Options avancées",
  "howShouldIChoose": "Comment devrais-je choisir",
  "gasLimit": "Limite de gaz",
  "maxPriorityGwei": "Frais de priorité max (GWEI)",
  "maxFeeSwei": "Frais max (GWEI)",
  "confirmTrasaction": "Confirmer la transaction",
  "selectTokenToSwap": "Sélectionner un jeton à échanger",
  "selectaToken": "Sélectionner un jeton",
  "getQuotes": "Obtenir des devis",
  "convertFrom": "Convertir de",
  "convertTo": "Convertir en",
  "enterTokenName": "Entrer le nom du jeton",
  "newQuoteIn": "Nouveau devis dans",
  "availableToSwap": "disponible pour l'échange",
  "swipeToSwap": "Glissez pour échanger",
  "wallet": "Portefeuille",
  "transactionHistory": "Historique des transactions",
  "viewOnEtherscan": "Voir sur l'explorateur",
  "shareMyPubliAdd": "Partager mon adresse publique",
  "settings": "Paramètres",
  "getHelp": "Obtenir de l'aide",
  "logout": "Déconnexion",
  "explorer": "Explorateur",
  "general": "Général",
  "generalDescription":
      "Conversion de devises, devise principale, langue et moteur de recherche",
  "networks": "Réseaux",
  "networksDescription": "Ajouter et modifier des réseaux RPC personnalisés",
  "contacts": "Contacts",
  "contactDescription": "Ajouter, modifier, supprimer et gérer vos comptes",
  "about": "À propos de {appName}",
  "@about": {
    "description": "à propos",
    "placeholders": {
      "appName": {"type": "String"}
    }
  },
  "currencyConversion": "Conversion de devises",
  "displayFiat":
      "Afficher les valeurs fiat en utilisant une devise spécifique dans l'application",
  "languageDescription":
      "Traduire l'application dans une autre langue prise en charge",
  "createNewAccount": "Créer un nouveau compte",
  "security": "Sécurité",
  "securityDescription": "Gérer les clés privées et exporter le portefeuille",
  "showPrivateKey": "Afficher la clé privée (Appuyez pour copier)",
  "tapHereToReveal":
      "Appuyez et maintenez pour révéler et copier la clé privée",
  "exportWallet": "Exporter le portefeuille",
  "tapHereToExportWallet":
      "Appuyez et maintenez pour exporter le portefeuille (Votre mot de passe actuel est utilisé pour l'importation)",
  "browser": "Navigateur",
  "learnMore": "En savoir plus",
  "securityNotePK":
      "Vous serez invité à entrer un mot de passe pour voir votre clé privée",
  "showSeedphrase":
      "Afficher la phrase secrète de récupération (Appuyez pour copier)",
  "securityNoteSD":
      "Vous serez invité à entrer un mot de passe pour voir votre phrase secrète de récupération",
  "privateKeyCopiedToClipboard": "Clé privée copiée dans le presse-papiers",
  "SRPCoipied": "Phrase secrète de récupération copiée dans le presse-papiers",
  "unkownContact": "Adresse inconnue",
  "somethingWentWrong": "Quelque chose a mal tourné",
  "rejectConfirmation": "Rejeter la confirmation",
  "rejectRequestConfirmation":
      "Êtes-vous sûr de vouloir rejeter cette demande?",
  "no": "Non",
  "dappIsRequesting": "Cette Dapp",
  "ethSign": "Signature Ethereum",
  "signData": "Signer les données",
  "approve": "Approuver",
  "reject": "Rejeter",
  "signMessage": "Signer le message",
  "personalSign": "Signature personnelle",
  "invalidInput": "Entrée invalide",
  "invalidAmount": "La valeur ne peut pas avoir plus de {} décimales.",
  "fileSendAdminDialog": "Voulez-vous envoyer un fichier à l'administrateur?",
  "sortBy": "Trier par",
  "addContact": "Ajouter un contact",
  "updateContact": "Mettre à jour le contact",
  "notEmpty": "ne doit pas être vide",
  "name": "Nom",
  "invalid": "Invalide",
  "publicAddressNotEmpty": "L'adresse publique ne doit pas être vide",
  "invalidAddress": "Adresse invalide",
  "publicAddress": "Adresse publique",
  "deleteWarning": "Êtes-vous sûr de vouloir supprimer ce contact?",
  "dappBrowser": "Navigateur Dapp",
  "error": "Erreur",
  "privateKey": "Clé privée",
  "enterPrivateKey": "Entrez la clé privée",
  "privateKeyNotEmpty": "La clé privée ne doit pas être vide",
  "passwordAtleast": "Le mot de passe doit contenir au moins 8 caractères",
  "openWallet": "Ouvrir le portefeuille",
  "scanQrCode": "Scanner le code QR",
  "walletConnect": "WalletConnect",
  "manageWCSession": "Gérer la session WalletConnect",
  "contactUs": "Nous contacter",
  "sendMessage": "Envoyez-nous un message",
  "viewFullHistory": "Voir l'historique complet sur l'explorateur",
  "noTransaction": "Vous n'avez aucune transaction!",
  "txSubmitted": "Transaction avec {txHash} soumise au réseau",
  "transactionFailed1": "Échec de la transaction",
  "transactionFailedMessage":
      "Échec de la soumission de la transaction au réseau",
  "confirmTransaction": "Confirmer la transaction",
  "platformFee": "Frais de plateforme",
  "status": "Statut",
  "confirmed": "Confirmé",
  "copyTxId": "Copier l'ID de la transaction",
  "transaction": "Transaction",
  "myContacts": "Mes contacts",
  "myAccount": "Mes comptes",
  "wcSessions": "Sessions WalletConnect",
  "wcEndDialog": "Voulez-vous mettre fin à la session avec toutes les dapps?",
  "endAll": "Mettre fin à tout",
  "endOne": "Voulez-vous mettre fin à la session avec {name}?",
  "end": "Terminer",
  "noWC": "Aucune session WalletConnect trouvée",
  "isRequesting": "demande une transaction",
  "estimateGas": "Frais de gaz estimés",
  "siteSuggested": "Suggestion du site",
  "amountWithFee": "Montant + frais de gaz",
  "connectToThis": "Se connecter à ce site?",
  "byClicking":
      "En cliquant sur se connecter, vous permettez à cette dapp de voir votre adresse publique. C'est une étape de sécurité importante pour protéger vos données contre les risques de phishing potentiels.",
  "chainsAreRequried": "chaînes demandées",
  "newTab": "Nouvel onglet",
  "createNewTab": "Créer un nouvel onglet",
  "searchOrType": "Rechercher ou taper une adresse web",
  "copied": "Copié",
  "pkCopied": "Clé privée copiée dans le presse-papiers",
  "addCopied": "Adresse publique copiée dans le presse-papiers",
  "passwordIsInvalid": "Mot de passe invalide, veuillez réessayer",
  "updateAvailable": "Mise à jour disponible",
  "availableVersions": "Version disponible",
  "newVersions": "Nouvelle version de {appName} disponible sur l'App Store.",
  "currentVersion": "Version actuelle : ",
  "improvePerformance": "Amélioration des performances et de la stabilité.",
  "couldNot": "Impossible de lancer",
  'somethingWentWrongInitial':
      "Quelque chose s'est mal passé, veuillez vérifier votre connexion Internet",
  "retry": "réessayer"
};

String getText(BuildContext context, {required String key}) {
  return Translations.of(context).get(key).replaceAll('{appName}', appName);
}

getTextWithPlaceholder(BuildContext context,
    {required String key, required String string}) {
  String value = Translations.of(context).get(key);
  return value.replaceAll(RegExp(r'{(.*?)}'), string);
}
