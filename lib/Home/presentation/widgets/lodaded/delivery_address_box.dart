import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_app/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:supermarket_app/Shared/blocs/location_bloc/location_bloc.dart';

import 'current_location_text.dart';

class DeliveryAddressBox extends StatelessWidget {
  const DeliveryAddressBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesBloc, AddressesState>(
      builder: (context, state) {
        if (state is AddressesFetched) {
          return ListTile(
            horizontalTitleGap: 0,
            //contentPadding: ,
            leading: const Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            title: Row(
              children: [
                Text(
                  'Deliver To: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                state.selectedAddress == null
                    ? BlocProvider<LocationBloc>(
                        create: (context) =>
                            LocationBloc()..add(DetectCurrentLocation()),
                        child: CurrentLocationText(),
                      )
                    : Text(state.selectedAddress!.city),
              ],
            ),
            trailing: TextButton(
              child: Text('Change'),
              onPressed: () {},
            ),
          );
        }
        return Container();
      },
    );
  }
}
