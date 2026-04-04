// test.ts
import { handler } from './src/functions/api';

handler({
  httpMethod: 'GET',
  path: '/health',
  queryStringParameters: null,
  body: null,
} as any).then(console.log);