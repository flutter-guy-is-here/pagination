import 'package:pagination/models/module.dart';

List<Module> modulesList = [
  Module(
    name: "Systèmes d’informations 1",
    coef: 3,
    year: "L2",
    hours: 25,
  ),
  Module(
    name: "Architecture des Ordinateurs 1	",
    coef: 2,
    year: "L2",
    hours: 20,
  ),
  Module(
    name: "Algorithmique et Structures de données	",
    coef: 5,
    year: "L2",
    hours: 30,
  ),
  Module(
    name: "Analyse numérique	",
    coef: 2,
    year: "L2",
    hours: 20,
  ),
  Module(
    name: "Logique mathématique	",
    coef: 2,
    year: "L2",
    hours: 20,
  ),
  Module(
    name: "Probabilités et Statistiques	",
    coef: 2,
    year: "L2",
    hours: 25,
  ),
  Module(
    name: "Programmation Orientée Objet	",
    coef: 3,
    year: "L2",
    hours: 25,
  ),
  Module(
    name: "Bases de Données 1	",
    coef: 3,
    year: "L3",
    hours: 28,
  ),
  Module(
    name: "Systèmes d’informations 1",
    coef: 3,
    year: "L3",
    hours: 25,
  ),
  Module(
    name: "Génie Logiciel 1	",
    coef: 3,
    year: "L3",
    hours: 27,
  ),
  Module(
    name: "Systèmes d’exploitation 1",
    coef: 4,
    year: "L3",
    hours: 25,
  ),
  ...List.generate(
    10,
    (index) => Module(
      name: "Module number $index",
      coef: index % 6,
      year: "L${index % 3}+1",
      hours: index * 9 % 30,
    ),
  )
];
