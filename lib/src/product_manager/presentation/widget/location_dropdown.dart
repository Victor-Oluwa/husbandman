import 'package:flutter/material.dart';
List<Country> countries = [
  Country(
    name: 'Country 1',
    states: [
      Statee(
        name: 'State 1',
        cities: [City(name: 'City 1'), City(name: 'City 2')],
      ),
      Statee(
        name: 'State 2',
        cities: [City(name: 'City 3'), City(name: 'City 4')],
      ),
    ],
  ),
  // Add more countries as needed
];



class Country {
  final String name;
  final List<Statee> states;

  Country({required this.name, required this.states});
}

class Statee {
  final String name;
  final List<City> cities;

  Statee({required this.name, required this.cities});
}

class City {
  final String name;

  City({required this.name});
}



class LocationDropdown extends StatefulWidget {
  @override
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  Country? selectedCountry;
  Statee? selectedState;
  City? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<Country>(
          value: selectedCountry,
          items: countries.map((Country country) {
            return DropdownMenuItem<Country>(
              value: country,
              child: Text(country.name),
            );
          }).toList(),
          onChanged: (Country? newValue) {
            setState(() {
              selectedCountry = newValue;
              selectedState = null; // Reset state selection
              selectedCity = null; // Reset city selection
            });
          },
        ),
        if (selectedCountry != null)
          DropdownButton<Statee>(
            value: selectedState,
            items: selectedCountry!.states.map((Statee state) {
              return DropdownMenuItem<Statee>(
                value: state,
                child: Text(state.name),
              );
            }).toList(),
            onChanged: (Statee? newValue) {
              setState(() {
                selectedState = newValue;
                selectedCity = null; // Reset city selection
              });
            },
          ),
        if (selectedState != null)
          DropdownButton<City>(
            value: selectedCity,
            items: selectedState!.cities.map((City city) {
              return DropdownMenuItem<City>(
                value: city,
                child: Text(city.name),
              );
            }).toList(),
            onChanged: (City? newValue) {
              setState(() {
                selectedCity = newValue;
              });
            },
          ),
      ],
    );
  }
}
