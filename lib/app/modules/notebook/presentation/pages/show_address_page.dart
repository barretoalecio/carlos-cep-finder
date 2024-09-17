import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/utils/extensions/string_extension.dart';
import '../../domain/entities/address_data_entity.dart';
import '../widgets/address_input_widget.dart';

class ShowAddressPage extends StatefulWidget {
  const ShowAddressPage({
    super.key,
    required this.addressDataEntity,
  });

  final AddressDataEntity addressDataEntity;

  @override
  State<ShowAddressPage> createState() => _ShowAddressPageState();
}

class _ShowAddressPageState extends State<ShowAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: IconButton(
          tooltip: 'Retornar',
          padding: EdgeInsets.zero,
          onPressed: () => Modular.to.maybePop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSecondaryFixed,
          ),
        ),
        title: Text(
          'Visualizar Endereço',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF141514),
                fontSize: 24.0,
              ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Wrap(
                  runSpacing: 32.0,
                  children: [
                    AddressInputWidget(
                      enabled: false,
                      labelText: 'CEP',
                      textEditingController: TextEditingController(
                        text: widget.addressDataEntity.postalCode
                            .toPostalCodeFormat(),
                      ),
                    ),
                    AddressInputWidget(
                      enabled: false,
                      labelText: 'Endereço',
                      textEditingController: TextEditingController(
                        text: widget.addressDataEntity.fullAddress,
                      ),
                    ),
                    AddressInputWidget(
                      enabled: false,
                      labelText: 'Número',
                      textInputType: TextInputType.number,
                      textEditingController: TextEditingController(
                        text: widget.addressDataEntity.number != null
                            ? widget.addressDataEntity.number.toString()
                            : ' ',
                      ),
                    ),
                    AddressInputWidget(
                      enabled: false,
                      labelText: 'Complemento',
                      textEditingController: TextEditingController(
                        text: widget.addressDataEntity.complement != null &&
                                widget.addressDataEntity.complement!
                                    .trim()
                                    .isNotEmpty
                            ? widget.addressDataEntity.complement.toString()
                            : ' ',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
