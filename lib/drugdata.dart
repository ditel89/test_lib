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
    name: "drug",
    location: "118-96-7",
    distance: "Trinitrotoluene",
    gravity: "3.711 m/s",
    description:
        "Trinitrotoluene more specifically 2,4,6-trinitrotoluene, is a chemical compound with the formula C6H2(NO2)3CH3. This yellow solid is occasionally used as a reagent in chemical synthesis, but it is best known as an explosive material with convenient handling properties. The explosive yield of TNT is considered to be the standard comparative convention of bombs and the destructiveness of explosives. In chemistry, TNT is used to generate charge transfer salts.",
    image: "img/tnt.png",
    casno: "118-96-7",
    formula: "C7H5N3O6",
    density: "1.654g/cm3",
    vaporpressure: "0.0002mmHg",
    boilingpoint: "240°C",
    meltingpoint: "80.35°C",
  ),
  const DrugData(
    id: "202",
    name: "drug",
    location: "121-82-4",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "Neptune is the eighth and farthest known  from the Sun in the Solar System. In the Solar System, it is the fourth-largest  by diameter, the third-most-massive , and the densest giant . Neptune is 17 times the mass of Earth and is slightly more massive than its near-twin Uranus, which is 15 times the mass of Earth and slightly larger than Neptune. Neptune orbits the Sun once every 164.8 years at an average distance of 30.1 astronomical units (4.50×109 km). It is named after the Roman god of the sea and has the astronomical symbol ♆, a stylised version of the god Neptune's trident",
    image: "img/RDX.png",
    casno: "121-82-4",
    formula: "C3H6N6O6",
    density: "1.858g/cm3",
    vaporpressure: "-",
    boilingpoint: "234°C",
    meltingpoint: "205.5°C",
  ),
  const DrugData(
    id: "203",
    name: "drug",
    location: "1978-11-02",
    distance: "54.6m Km",
    gravity: "3.711 m/s ",
    description:
        "The Moon is an astronomical body that orbits  Earth, being Earth's only permanent natural satellite. It is the fifth-largest natural satellite in the Solar System, and the largest among ary satellites relative to the size of the  that it orbits (its primary). Following Jupiter's satellite Io, the Moon is second-densest satellite among those whose densities are known.",
    image: "img/PETN.png",
    casno: "1978-11-02",
    formula: "C5H8N4O12",
    density: "1.77g/cm3",
    vaporpressure: "-",
    boilingpoint: "180°C",
    meltingpoint: "141.3°C",
  ),
];
