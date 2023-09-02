import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/env/env.dart';
import '../../../core/extensions/formatter_extensions.dart';
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
    super.initState();
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
            final model = controller.productModel!;
            nomeEC.text = model.name;
            precoEC.text = model.price.currencyPTBR;
            descricaoEC.text = model.description;
            break;
          case ProductDatailsStateStatus.error:
            hideLoader();
            showError(controller.errorMessage!);
            break;
          case ProductDatailsStateStatus.errorLoadProduct:
            hideLoader();
            showError('Erro ao carregar o produto para alteração');
            Navigator.of(context).pop();
            break;
          case ProductDatailsStateStatus.deleted:
          case ProductDatailsStateStatus.saved:
            hideLoader();
            Navigator.pushNamed(context, '/products/');
            break;
          case ProductDatailsStateStatus.uploaded:
            hideLoader();
            break;
        }
      });
      controller.loadProduct(widget.productId);
    });
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
                      Navigator.pushNamed(context, '/products/');
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
                        child: Visibility(
                          visible: widget.productId != null,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar'),
                                    content: Text('Confirma a exclusão do produto ${controller.productModel!.name}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancelar',
                                          style: context.textStyles.textBold.copyWith(color: Colors.red),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          controller.deleteProduct();
                                        },
                                        child: Text(
                                          'Confirmar',
                                          style: context.textStyles.textBold,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Deletar',
                              style: context.textStyles.textBold.copyWith(color: Colors.red),
                            ),
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
