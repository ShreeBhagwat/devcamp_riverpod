// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_future_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsFutureHash() => r'882319bca927eeaa0ae784a5c49179cb5afad275';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [productsFuture].
@ProviderFor(productsFuture)
const productsFutureProvider = ProductsFutureFamily();

/// See also [productsFuture].
class ProductsFutureFamily extends Family<AsyncValue<List<Products>>> {
  /// See also [productsFuture].
  const ProductsFutureFamily();

  /// See also [productsFuture].
  ProductsFutureProvider call(
    String id,
  ) {
    return ProductsFutureProvider(
      id,
    );
  }

  @override
  ProductsFutureProvider getProviderOverride(
    covariant ProductsFutureProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsFutureProvider';
}

/// See also [productsFuture].
class ProductsFutureProvider extends FutureProvider<List<Products>> {
  /// See also [productsFuture].
  ProductsFutureProvider(
    String id,
  ) : this._internal(
          (ref) => productsFuture(
            ref as ProductsFutureRef,
            id,
          ),
          from: productsFutureProvider,
          name: r'productsFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productsFutureHash,
          dependencies: ProductsFutureFamily._dependencies,
          allTransitiveDependencies:
              ProductsFutureFamily._allTransitiveDependencies,
          id: id,
        );

  ProductsFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<Products>> Function(ProductsFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsFutureProvider._internal(
        (ref) => create(ref as ProductsFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  FutureProviderElement<List<Products>> createElement() {
    return _ProductsFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductsFutureRef on FutureProviderRef<List<Products>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductsFutureProviderElement
    extends FutureProviderElement<List<Products>> with ProductsFutureRef {
  _ProductsFutureProviderElement(super.provider);

  @override
  String get id => (origin as ProductsFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
