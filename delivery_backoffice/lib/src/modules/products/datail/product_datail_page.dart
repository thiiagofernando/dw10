import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/env/env.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/helpers/upload_html_helper.dart';
import '../../../core/ui/styles/text_styles.dart';
import 'product_datail_controller.dart';

class ProductDatailPage extends StatefulWidget {
  final int? productId;

  const ProductDatailPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDatailPage> createState() => _ProductDatailPageState();
}

class _ProductDatailPageState extends State<ProductDatailPage> with Loader, Messages {
  final controller = Modular.get<ProductDatailController>();
  final formKey = GlobalKey<FormState>();
  final nomeEC = TextEditingController();
  final precoEC = TextEditingController();
  final descricaoEC = TextEditingController();
  late final ReactionDisposer statusDisposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reaction((_) => controller.status, (status) {
        switch (status) {
          case ProductDatailsStateStatus.initial:
            break;
          case ProductDatailsStateStatus.loading:
            showLoader();
            break;
          case ProductDatailsStateStatus.loaded:
            hideLoader();
            break;
          case ProductDatailsStateStatus.error:
            hideLoader();
            showError(controller.errorMessage!);
            break;
          case ProductDatailsStateStatus.errorLoadProduct:
            // TODO: Handle this case.
            break;
          case ProductDatailsStateStatus.deleted:
            // TODO: Handle this case.
            break;
          case ProductDatailsStateStatus.uploaded:
            hideLoader();
            break;
          case ProductDatailsStateStatus.saved:
            hideLoader();
            Navigator.pushNamed(context, '/products/');
            break;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nomeEC.dispose();
    precoEC.dispose();
    descricaoEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthButtonAction = context.percentWidth(.40);
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 30),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.productId != null ? 'Alterar' : 'Adicionar'} Produto',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Observer(
                        builder: (_) {
                          if (controller.imagePatch != null) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                '${Env.instance.get('backend_base_url')}${controller.imagePatch}',
                                width: 200,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.9),
                          ),
                          onPressed: () {
                            UploadHtmlHelper().startUpload(
                              controller.uploadImageProduct,
                            );
                          },
                          child: Observer(
                            builder: (_) {
                              return Text('${controller.imagePatch == null ? 'Adicionar' : 'Alterar'} Foto');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomeEC,
                          decoration: const InputDecoration(
                            label: Text('Nome'),
                          ),
                          validator: Validatorless.required('Nome Obrigatório'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: precoEC,
                          decoration: const InputDecoration(
                            label: Text('Preço'),
                          ),
                          validator: Validatorless.required('Preço Obrigatório'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(moeda: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descricaoEC,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                validator: Validatorless.required('Descrição Obrigatória'),
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: widthButtonAction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: widthButtonAction / 2,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                          onPressed: () {},
                          child: Text(
                            'Deletar',
                            style: context.textStyles.textBold.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        width: widthButtonAction / 2,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            final valid = formKey.currentState?.validate() ?? false;
                            if (valid) {
                              if (controller.imagePatch == null) {
                                showWarning('Foto obrigatória , por favor adicione uma foto!');
                                return;
                              } else {
                                controller.save(
                                  nomeEC.text,
                                  UtilBrasilFields.converterMoedaParaDouble(precoEC.text),
                                  descricaoEC.text,
                                );
                              }
                            }
                          },
                          child: Text(
                            'Salvar',
                            style: context.textStyles.textBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
