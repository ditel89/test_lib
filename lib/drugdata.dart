class DrugData {
  final int typeid;
  final String casno;
  final String chemicalformula;
  final String molecularweight;
  final String density;
  final String meltingpoint;
  final String boilingpoint;
  final String vaporpressure;
  final String solubilitywater;
  final String solublesolvent;
  final String licensedata;
  final String pregnancycategory;
  final String dependanceliability;
  final String addictionliability;
  final String drugclass;
  final String bioavailability;
  final String metabolism;
  final String metabolites;
  final String onsetaction;
  final String eliminationhalflife;
  final String durationaction;
  final String excretion;
  final String ionizationenergy;
  //local data
  final String id;
  final String name;
  final String location;
  final String distance;
  final String gravity;
  final String description;
  final String image;
  final String formula;

  const DrugData({
    this.typeid,
    this.casno,
    this.chemicalformula,
    this.molecularweight,
    this.density,
    this.meltingpoint,
    this.boilingpoint,
    this.vaporpressure,
    this.solubilitywater,
    this.solublesolvent,
    this.licensedata,
    this.pregnancycategory,
    this.dependanceliability,
    this.addictionliability,
    this.drugclass,
    this.bioavailability,
    this.metabolism,
    this.metabolites,
    this.onsetaction,
    this.eliminationhalflife,
    this.durationaction,
    this.excretion,
    this.ionizationenergy,
    //local data
    this.id,
    this.name,
    this.location,
    this.distance,
    this.gravity,
    this.description,
    this.image,
    this.formula,
  });

  factory DrugData.fromJson(Map<String, dynamic> json) {
    return DrugData(
      typeid: json['DataTypeTblID'],
      casno: json['CasNo'],
      chemicalformula: json['ChemicalFormula'],
      molecularweight: json['MolecularWeight'],
      density: json['Density'],
      meltingpoint: json['MeltingPoint'],
      boilingpoint: json['BoilingPoing'],
      vaporpressure: json['VaporPressure'],
      solubilitywater: json['SolubilityWater'],
      solublesolvent: json['SolubleSolvent'],
      licensedata: json['LicenseData'],
      pregnancycategory: json['PregnancyCategory'],
      dependanceliability: json['DependanceLiability'],
      addictionliability: json['AddictionLiability'],
      drugclass: json['DrugClass'],
      bioavailability: json['Bioavailability'],
      metabolism: json['Metabolism'],
      metabolites: json['Metabolites'],
      onsetaction: json['OnsetAction'],
      eliminationhalflife: json['EliminationHalflife'],
      durationaction: json['DurationAction'],
      excretion: json['Excretion'],
      ionizationenergy: json['IonizationEnergy'],
    );
  }
}

List<DrugData> drugdatas = [
  const DrugData(
    id: "201",
    name: "Ketamine",
    location: "6740-88-1",
    distance: "Trinitrotoluene",
    gravity: "3.711 m/s",
    description:
        "Ketamine is a medication primarily used for induction and maintenance of anesthesia. It induces dissociative anesthesia, a trance-like state providing pain relief, sedation, and amnesia. The distinguishing features of ketamine anesthesia are preserved breathing and airway reflexes, stimulated heart function with increased blood pressure, and moderate bronchodilation. At lower, sub-anesthetic doses, ketamine is a promising agent for pain and treatment-resistant depression. However, the antidepressant action of a single administration of ketamine wanes with time, and the effects of repeated use have not been sufficiently studied.",
    image: "img/Ketamine.png",
    casno: "6740-88-1",
    formula: "C7H5N3O6",
    density: "1.654g/cm3",
    vaporpressure: "0.0002mmHg",
    boilingpoint: "240°C",
    meltingpoint: "80.35°C",
  ),
  const DrugData(
    id: "202",
    name: "MDMA",
    location: "42542-10-9",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "3,4-Methyl​enedioxy​methamphetamine (MDMA), commonly known as ecstasy, E, or molly, is a psychoactive drug primarily used for recreational purposes. The desired effects include altered sensations, increased energy, empathy, as well as pleasure. When taken by mouth, effects begin in 30 to 45 minutes and last 3 to 6 hours.",
    image: "img/mdma.png",
    casno: "42542-10-9",
    formula: "C11H15NO2",
    density: "1.858g/cm3",
    vaporpressure: "-",
    boilingpoint: "105°C",
    meltingpoint: "205.5°C",
  ),
  const DrugData(
    id: "203",
    name: "Morphine",
    location: "57-27-2",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "57-27-2",
    formula: "C17H19NO3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
  const DrugData(
    id: "204",
    name: "Alfentanil",
    location: "71195-58-9",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "71195-58-9",
    formula: "C21H32N6O3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "140.8°C",
  ),
  const DrugData(
    id: "205",
    name: "Amphetamine",
    location: "57-27-2",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "57-27-2",
    formula: "C17H19NO3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
  const DrugData(
    id: "206",
    name: "Codeine Phosphate Hydrate",
    location: "76-57-3",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "57-27-2",
    formula: "C18H21NO3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
  const DrugData(
    id: "207",
    name: "Diazepam",
    location: "57-27-2",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "57-27-2",
    formula: "C17H19NO3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
  const DrugData(
    id: "208",
    name: "Fentanyl",
    location: "57-27-2",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "57-27-2",
    formula: "C17H19NO3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
  const DrugData(
    id: "209",
    name: "Oxycodone",
    location: "57-27-2",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Morphine is a pain medication of the opiate family that is found naturally in a dark brown, resinous form, from the poppy plant (Papaver somniferum). It can be taken orally or injected. It acts directly on the central nervous system (CNS) to induce analgesia and alter perception and emotional response to pain. Physical and psychological dependence and tolerance may develop with repeated administration. It can be taken for both acute pain and chronic pain and is frequently used for pain from myocardial infarction, kidney stones, and during labor.",
    image: "img/morphine.png",
    casno: "57-27-2",
    formula: "C17H19NO3",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
];
