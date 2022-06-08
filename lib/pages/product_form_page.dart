import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/product.dart';
import 'package:udemy_shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    // _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool validatorUrlImage(String url) {
    bool _isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;

    final _url = url.toLowerCase();
    bool _endsWithFile =
        _url.endsWith('png') || _url.endsWith('jpg') || _url.endsWith('jpeg');

    return _isValidUrl && _endsWithFile;
  }

  bool validatorTextInput(String text, int tamanho) {
    bool _isNotEmpty = text.trim().isNotEmpty;
    bool _hasGoodLenght = text.trim().length >= tamanho;

    return _isNotEmpty && _hasGoodLenght;
  }

  void submitForm() {
    final _isValid = _formKey.currentState?.validate() ?? false;

    if (!_isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    Provider.of<ProductList>(
      context,
      listen: false,
    )
        .saveProductFromData(_formData)
        .catchError((onError) => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Ops! Ocorreu um erro.'),
                  content: const Text('Não consegui salvar seu produto!'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'))
                  ],
                )))
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de produtos'),
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration:
                            const InputDecoration(labelText: 'nome do produto'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocus);
                        },
                        onSaved: (name) => _formData['name'] = name ?? '',
                        validator: (name) {
                          final _name = name ?? '';

                          if (!validatorTextInput(_name, 2)) {
                            return 'Insira uma nome válido!';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: const InputDecoration(labelText: 'preço'),
                        focusNode: _priceFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '0'),
                        validator: (price) {
                          final _price = double.tryParse(price ?? '') ?? -1;

                          if (_price <= 0) {
                            return 'Informe um preço válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration:
                            const InputDecoration(labelText: 'descrição'),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onSaved: (description) =>
                            _formData['description'] = description ?? '',
                        validator: (description) {
                          final _description = description ?? '';

                          if (!validatorTextInput(_description, 10)) {
                            return 'Insira uma descrição válida. Mínimo 10 caracteres!';
                          }

                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Url da imagem'),
                              focusNode: _imageUrlFocus,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              onFieldSubmitted: (_) => submitForm(),
                              onSaved: (imageUrl) =>
                                  _formData['imageUrl'] = imageUrl ?? '',
                              validator: (image) {
                                final _image = image ?? '';

                                if (!validatorUrlImage(_image)) {
                                  return 'Insira uma url válida!';
                                }

                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Url?')
                                : Image.network(_imageUrlController.text),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
    );
  }
}
