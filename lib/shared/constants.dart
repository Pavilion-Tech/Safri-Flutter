  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'network/local/cache_helper.dart';

IconData changeIconByLang() => CacheHelper.getData(key: "locale")=="en"? Icons.keyboard_arrow_right:Icons.keyboard_arrow_left;