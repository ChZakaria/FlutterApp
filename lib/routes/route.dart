import 'package:flutter/material.dart';

// Define Routes
// importing barrel file for all the pages needed ( found in pages folder )
import '../pages/pages.dart';

// Route Names
const String loginPage = 'login';
const String vehiculeListPage = 'vehiculeList';
const String contratsListPage = "contratsList";
const String chargeFixesListPage = "chargeFixesList";
const String fournisseursListPage = "fournisseursList";
const String intermidiairesListPage = "intermidiairesList";
const String regelementsListPage = "regelementsList";
const String supplementsListPage = "supplementsList";
const String entretiensListPage = "entretiensList";
const String locatairesListPage = "locatairesList";
const String dashboard = "dashboard";
//const String settingsPage = 'settings';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case vehiculeListPage:
      return MaterialPageRoute(builder: (context) => VehiculeList());
    case contratsListPage:
      return MaterialPageRoute(builder: (context) => ContratList());
      case chargeFixesListPage:
      return MaterialPageRoute(builder: (context) => ChargesFixesList());
      case fournisseursListPage:
      return MaterialPageRoute(builder: (context) => FournisseurList());
      case intermidiairesListPage:
      return MaterialPageRoute(builder: (context) => IntermediairesList());
      case regelementsListPage:
      return MaterialPageRoute(builder: (context) => ReglementsList());
      case supplementsListPage:
      return MaterialPageRoute(builder: (context) => SupplementList());
      case entretiensListPage:
      return MaterialPageRoute(builder: (context) => EntretienList());
      case locatairesListPage:
      return MaterialPageRoute(builder: (context) => LocatairesList());
       case dashboard:
      return MaterialPageRoute(builder: (context) => Dashboard());

    //   return MaterialPageRoute(builder: (context) => SettingsPage());
    default:
      throw ('This route name does not exit');
  }
}
