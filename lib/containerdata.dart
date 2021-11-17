class ContainerData {
  final int typeid;
  final String date;
  final String pipelength;
  final String pipemagneticfield;
  final String pipepressure;
  final String pipetemp;
  final String pipehumidity;
  final String heatertemp;
  final String outtemp;
  final String outhumidity;
  final String outairpressure;
  final String smearmatrix;
  final String samplelevel;
  final String desc;

  const ContainerData({
    this.typeid,
    this.date,
    this.pipelength,
    this.pipemagneticfield,
    this.pipepressure,
    this.pipetemp,
    this.pipehumidity,
    this.heatertemp,
    this.outtemp,
    this.outhumidity,
    this.outairpressure,
    this.smearmatrix,
    this.samplelevel,
    this.desc,
  });
  factory ContainerData.fromJson(Map<String, dynamic> json) {
    return ContainerData(
      typeid: json['DataTypeTblID'],
      date: json['Date'],
      pipelength: json['PipeLength'],
      pipemagneticfield: json['PipeMageneticField'],
      pipepressure: json['PipePressure'],
      pipetemp: json['PipeTemp'],
      pipehumidity: json['PipeHumidity'],
      heatertemp: json['HeaterTemp'],
      outtemp: json['OutTemp'],
      outhumidity: json['OutHumidity'],
      outairpressure: json['OutAirPressure'],
      smearmatrix: json['SmearMatrix'],
      samplelevel: json['SampleLevel'],
      desc: json['Desc'],
    );
  }
}
