// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:wire_flutter_todo/const/FilterValues.dart';
import 'package:wire_flutter_todo/const/ArchSampleKeys.dart';

class FilterButton extends StatelessWidget {
  final PopupMenuItemSelected<TodoFilterValue> onSelected;
  final TodoFilterValue activeFilter;
  final bool isActive;

  FilterButton({this.onSelected, this.activeFilter, this.isActive, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: Theme.of(context).accentColor);
    final button = _Button(
      onSelected: onSelected,
      activeFilter: activeFilter,
      activeStyle: activeStyle,
      defaultStyle: defaultStyle,
    );

    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: Duration(milliseconds: 150),
      child: isActive ? button : IgnorePointer(child: button),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<TodoFilterValue> onSelected;
  final TodoFilterValue activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TodoFilterValue>(
      key: ArchSampleKeys.filterButton,
      tooltip: 'Filter Todos',
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<TodoFilterValue>>[
        PopupMenuItem<TodoFilterValue>(
          key: ArchSampleKeys.allFilter,
          value: TodoFilterValue.ALL,
          child: Text(
            'Show All',
            style: activeFilter == TodoFilterValue.ALL
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<TodoFilterValue>(
          key: ArchSampleKeys.activeFilter,
          value: TodoFilterValue.ACTIVE,
          child: Text(
            'Show Active',
            style: activeFilter == TodoFilterValue.ACTIVE
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<TodoFilterValue>(
          key: ArchSampleKeys.completedFilter,
          value: TodoFilterValue.COMPLETED,
          child: Text(
            'Show Completed',
            style: activeFilter == TodoFilterValue.COMPLETED
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}