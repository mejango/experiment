import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:table_builder/index.dart';
import 'package:decorated_text/index.dart';
import 'package:network/index.dart';
import 'package:app1_cells/index.dart';

class Project {
  final String? name;
  final int? createdAt;
  final String? logoUri;

  Project(
      {this.name, this.createdAt, this.logoUri});

  factory Project.fromMap(Map<String?, Object?> map) {
    return Project(
      name: map["name"] as String?,
      createdAt: map["createdAt"] as int?,
      logoUri: map["logoUri"] as String?,
    );
  }
}

class Projects {
  Future<List<Object?>> get({
    required num pageSize,
    num pageNumber = 0,
    num startTimestamp = 0,
  }) async {

    final params = {
      "query": """
        query MyQuery {
          projects(orderBy: "trendingScore", orderDirection: "desc") {
            items {
              name,
              createdAt,
              logoUri
            }
          }
        }
      """
    };

    print("calling");    
    final response = await Network.post(
      address: "https://bendystraw.xyz/3ZLSSbdfZMTmmwtBsevou9AP/graphql",
      params: params,
      headers: {
        "Content-Type": "application/json",
      },
    );

    return await compute<PostResponse, List<Object>>(
      _streamableDataFromResponse,
      response
    );
  }

  List<Object> _streamableDataFromResponse(PostResponse response) {
    final dataConvertedToJson = response.body;
    final List projects = dataConvertedToJson["data"]["projects"]["items"] ?? [];

    final data = projects.map((json) {
      return Project.fromMap(json);
    }).toList();

    return data;
  }
}

class LandingStreamTable extends StreamTable<StreamableTableRowData,
    StreamableTableSectionHeaderData, StreamableTableHeaderData> {
  Widget buildLandingCell({
    LandingItemData? rowData,
    int? rowIndex,
    int? sectionIndex,
  }) {
    return LandingItemCell(
      title: rowData?.title,
      note: "" + (rowData?.description ?? ""),
      image: rowData?.image,
      timestamp: rowData?.timestamp,
    );
  }

  @override
  Widget? buildRow({
    BuildContext? context,
    StreamableTableRowData? rowData,
    int? rowIndex,
    int? sectionIndex,
  }) {
    if (rowData is LandingItemData) {
      return buildLandingCell(
        rowData: rowData,
        rowIndex: rowIndex,
        sectionIndex: sectionIndex,
      );
    }

    return null;
  }
}


mixin LandingArtboardData implements TableBuilder {
    @override
    final streamTable = LandingStreamTable();

      LandingItemData dataForProject(Project project) {
        final decoratedTitle = WeightDecoratedText();

        decoratedTitle.addSection(text: project.name ?? '');

        String? logoUri = project.logoUri;

        if (logoUri != null) {
          logoUri = logoUri.replaceAll("ipfs://", "https://jbm.infura-ipfs.io/ipfs/");
        }

        return LandingItemData(
          title: decoratedTitle,
          description: '',
          image: logoUri != null ? Image.network(logoUri) : null,
          section: 0,
          timestamp: project.createdAt ?? 0,
        );
      }
}
