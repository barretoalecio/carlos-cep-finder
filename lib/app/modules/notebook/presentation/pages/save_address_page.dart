import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/shared/presentation/widgets/buttons/filled_buttons.dart';
import '../../../../core/shared/presentation/widgets/snack_bar/konsi_snack_bar.dart';
import '../../../../core/utils/extensions/string_extension.dart';
import '../../domain/parameters/address_data_parameters.dart';
import '../controllers/blocs/notebook_bloc.dart';
import '../controllers/events/save_address_event.dart';
import '../controllers/states/successfully_saved_address_state.dart';
import '../widgets/address_input_widget.dart';

class SaveAddressPage extends StatefulWidget {
  const SaveAddressPage({
    super.key,
    required this.postalCode,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
  });

  final String postalCode;
  final String fullAddress;
  final double? latitude;
  final double? longitude;

  @override
  State<SaveAddressPage> createState() => _SaveAddressPageState();
}

class _SaveAddressPageState extends State<SaveAddressPage> {
  late final TextEditingController numberTextEditingController;
  late final TextEditingController complementTextEditingController;
  late final NotebookBloc notebookBloc;

  @override
  void initState() {
    notebookBloc = Modular.get();
    numberTextEditingController = TextEditingController(text: ' ');
    complementTextEditingController = TextEditingController(text: ' ');
    super.initState();
  }

  @override
  void dispose() {
    numberTextEditingController.dispose();
    complementTextEditingController.dispose();
    super.dispose();
  }

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
          'Revisão',
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
            BlocConsumer<NotebookBloc, AppState>(
              bloc: notebookBloc,
              listener: (context, state) {
                KonsiSnackBar.showSnackBar(context, state);
                if (state is SuccessfullySavedAddressState) {
                  Modular.to.maybePop(context);
                }
              },
              builder: (context, state) {
                return Expanded(
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
                            text: widget.postalCode.toPostalCodeFormat(),
                          ),
                        ),
                        AddressInputWidget(
                          enabled: false,
                          labelText: 'Endereço',
                          textEditingController:
                              TextEditingController(text: widget.fullAddress),
                        ),
                        AddressInputWidget(
                          enabled: true,
                          labelText: 'Número',
                          textInputType: TextInputType.number,
                          textEditingController: numberTextEditingController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        AddressInputWidget(
                          enabled: true,
                          labelText: 'Complemento',
                          textEditingController:
                              complementTextEditingController,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: 56,
                child: MediumButton(
                  onPressed: () => notebookBloc.add(
                    SaveAddressEvent(
                      parameters: AddressDataParameters(
                        postalCode: widget.postalCode,
                        fullAddress: widget.fullAddress,
                        latitude: widget.latitude,
                        longitude: widget.longitude,
                        complement: complementTextEditingController.text.trim(),
                        number: numberTextEditingController.text
                                .trim()
                                .isNotEmpty
                            ? int.parse(numberTextEditingController.text.trim())
                            : null,
                      ),
                    ),
                  ),
                  text: 'Confirmar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
