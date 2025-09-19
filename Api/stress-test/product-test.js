import http from 'k6/http';
import { check } from 'k6';

export const options = {
  scenarios: {
    cache_test: {
      executor: 'ramping-vus',
      startVUs: 1,
      stages: [
        { duration: '7s', target: 3 },  // subimos de 1 a 3 VUs
        { duration: '7s', target: 5 },  // subimos de 3 a 5 VUs
        { duration: '6s', target: 5 },  // mantenemos 5 VUs hasta completar 20s
      ],
      exec: 'testCacheEndpoint',
    }
    // nocache_test: {
    //   executor: 'ramping-vus',
    //   startVUs: 1,
    //   stages: [
    //     { duration: '7s', target: 3 },
    //     { duration: '7s', target: 5 },
    //     { duration: '6s', target: 5 },
    //   ],
    //   exec: 'testNoCacheEndpoint',
    // }
  }
};

const BASE_URL = 'https://medisupply-app-669548149164.us-east1.run.app/products';

export function testCacheEndpoint() {
  const res = http.get(`${BASE_URL}/cache?limit=300`, { tags: { endpoint: 'cache' } });
  check(res, {
    'status 200': (r) => r.status === 200,
    'response < 500ms': (r) => r.timings.duration < 500,
  });
}

// export function testNoCacheEndpoint() {
//   const res = http.get(`${BASE_URL}/no-cache?limit=300`, { tags: { endpoint: 'nocache' } });
//   check(res, {
//     'status 200': (r) => r.status === 200,
//     'response < 500ms': (r) => r.timings.duration < 500,
//   });
// }


