const String tableName = "cached_companies";

class CachedCompaniesRows {
  static const String id = "_id";
  static const String isFavourite = "is_favourite";
  static const String companyName = "company_name";
  static const String companyId = "company_id";
  static const String logoUrl = "logo_url";
}

class CachedCompanies {
  final int? id;
  final int isFavourite;
  final int companyId;
  final String companyName;
  final String logoUrl;

  CachedCompanies({
    required this.isFavourite,
    required this.companyId,
    required this.companyName,
    required this.logoUrl,
    required this.id,
  });

  CachedCompanies copyWith({
    int? id,
    String? companyName,
    String? logoUrl,
    int? companyId,
    int? isFavourite,
  }) =>
      CachedCompanies(
          id: id ?? this.id,
          companyName: companyName ?? this.companyName,
          logoUrl: logoUrl ?? this.logoUrl,
          companyId: companyId ?? this.companyId,
          isFavourite: isFavourite ?? this.isFavourite);

  static CachedCompanies fromJson(Map<String, Object?> json) {
    return CachedCompanies(
        isFavourite: json[CachedCompaniesRows.isFavourite] as int,
        companyId: json[CachedCompaniesRows.companyId] as int,
        companyName: json[CachedCompaniesRows.companyName] as String,
        logoUrl: json[CachedCompaniesRows.logoUrl] as String,
        id: json[CachedCompaniesRows.id] as int);
  }

  Map<String, Object?> toJson() {
    return {
      CachedCompaniesRows.id: id,
      CachedCompaniesRows.isFavourite: isFavourite,
      CachedCompaniesRows.companyId: companyId,
      CachedCompaniesRows.companyName: companyName,
      CachedCompaniesRows.logoUrl: logoUrl,
    };
  }

  @override
  String toString() {
    return "id:$id isFavourite: $isFavourite companyId: $companyId companyName: $companyName logoUrl: $logoUrl ";
  }
}
