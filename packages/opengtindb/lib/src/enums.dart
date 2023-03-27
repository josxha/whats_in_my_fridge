enum Contents {
  lactoseFree("laktosefrei"),
  caffeineFree("koffeeinfrei"),
  dieticFood("diätetisches Lebensmittel"),
  glutenFree("glutenfrei"),
  fructoseFree("fruktosefrei"),
  bio("BIO-Lebensmittel nach EU-Ökoverordnung"),
  fairTrade("fair gehandeltes Produkt nach FAIRTRADE™-Standard"),
  vegetarian("vegetarisch"),
  vegan("vegan"),
  microPlastic("Warnung vor Mikroplastik"),
  mineralOil("Warnung vor Mineralöl"),
  nicotine("Warnung vor Nikotin");

  final String name;
  const Contents(this.name);
}

enum Packaging {
  mostlyPlastic("die Verpackung besteht überwiegend aus Plastik"),
  mostlyComposite("die Verpackung besteht überwiegend aus Verbundmaterial"),
  mostlyPaperCardboard("die Verpackung besteht überwiegend aus Papier/Pappe"),
  mostlyGlassCeramicClay("die Verpackung besteht überwiegend aus Glas/Keramik/Ton"),
  mostlyMetal("die Verpackung besteht überwiegend aus Metall"),
  isUnpacked("ist unverpackt"),
  freeFromPlastic("die Verpackung ist komplett frei von Plastik"),
  overPackaged("Artikel ist übertrieben stark verpackt"),
  packagedSparingly("Artikel ist angemessen sparsam verpackt"),
  depositSystemReusablePackaging("Pfandsystem / Mehrwegverpackung");

  final String desc;
  const Packaging(this.desc);
}

enum ApiError {
  ok("Operation war erfolgreich"),
  notFound("die EAN konnte nicht gefunden werden"),
  checksum("die EAN war fehlerhaft (Checksummenfehler)"),
  eanFormat("die EAN war fehlerhaft (ungültiges Format / fehlerhafte Ziffernanzahl)"),
  notGlobalUniqueEan("es wurde eine für interne Anwendungen reservierte EAN eingegeben (In-Store, Coupon etc.)"),
  accessLimitExceeded("Zugriffslimit auf die Datenbank wurde überschritten"),
  noProductName("es wurde kein Produktname angegeben"),
  productNameTooLong("der Produktname ist zu lang (max. 20 Zeichen)"),
  noOrWrongMainCategoryId("die Nummer für die Hauptkategorie fehlt oder liegt außerhalb des erlaubten Bereiches"),
  noOrWrongSubCategoryId("die Nummer für die zugehörige Unterkategorie fehlt oder liegt außerhalb des erlaubten Bereiches"),
  illegalDataInVendorField("unerlaubte Daten im Herstellerfeld"),
  illegalDataInDescField("unerlaubte Daten im Beschreibungsfeld"),
  dataAlreadySubmitted("Daten wurden bereits übertragen"),
  queryIdMissingOrWrong("die UserID/queryid fehlt in der Abfrage oder ist für diese Funktion nicht freigeschaltet"),
  unknownCommand("es wurde mit dem Parameter \"cmd\" ein unbekanntes Kommando übergeben");

  final String desc;
  const ApiError(this.desc);
}
