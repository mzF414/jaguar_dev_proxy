// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_dev_proxy/jaguar_dev_proxy.dart';

main() async {
  final server = Jaguar(port: 8085);

  // Proxy all html client requests to pub server
  // NOTE: Run pub server on port 8000 using command
  //     pub run build_runner serve web:8000
  server.addRoute(getOnlyProxy('/client/*', 'http://localhost:8000/'));

  server.getJson('/api/user', (Context ctx) => {'name': 'teja'});
  server.get('/client/version', (Context ctx) => '0.1');
  server.log.onRecord.listen(print);
  await server.serve(logRequests: true);
}
