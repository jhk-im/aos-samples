# Nuxt foundamental

## 1. What is an data fetching

- 서버에서 네트워크를 통해 가져와 애플리케이션 내에서 처리하거나 표시하는 과정
- 웹 개발에선 API 혹은 데이터 소스에 HTTP 요청을 보내 가져오는 것을 포함
- 서버, 데이터베이스, API, 로컬 파일 시스템, 외부 애플리케이션, 센서, 하드웨어 등등

### Nuxt data fetching

- `useFetch` composable
- `useAsyncData` composable
- `$fetch` library

#### Composable?

- Vue 앱의 컨텍스트에서 Vue 컴포지션 API를 활용하여 상태 저장 로직을 캡슐화하고 재사용하는 함수
- React hook과 매우 유사

#### API(Application Programming Interface)

- 애플리케이션이 정보를 요청하고 교환하는 방법에 대한 규치과 프로토콜을 정의
- 상호작용은 보통 요청과 응답을 포함하며 특정 엔드포인트 URL에서 발생

[JsonPlaceholder](https://jsonplaceholder.typicode.com)

## 2.useFetch - Composable

- 컴포넌트의 setup 함수 내에서 서버 측과 클라이언트 측 모두 데이터를 가져오는 가장 간단한 방법
- [FakeStoreAPI](https://fakestoreapi.com)

### useFetch의 동작

```javascript
<!-- pages/fetching.vue -->
<template>
  <div>
    <div v-for="product in products" :key="product.id">
      <h2>{{ product.title }}</h2>
      <p>{{ product.description }}</p>
      <img :src="product.image" alt="Product Image" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useFetch } from '#app';

const products = ref([]);

const { data } = await useFetch('https://fakestoreapi.com/products');
products.value = data.value;

console.log(products.value);
</script>
```

- useFtch 함수에 URL을 전달하여 데이터를 가져옴
- products 변수에 저장d
- 콘솔 출력
- template에서 v-for을 사용하여 데이터를 반복하여 렌더링
- localhost:3000/fetching에서 확인

## 3. useFetch dynamic URLS

```javascript
<!-- pages/fetching.vue -->
<template>
  <div>
    <div v-if="product">
      <h2>{{ product.title }}</h2>
      <p>{{ product.description }}</p>
      <img :src="product.image" alt="Product Image" />
    </div>
    <button @click="fetchProduct">Display a new product</button>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useFetch } from '#app';

// 초기 제품 ID 설정
const id = ref(1);

// useFetch 사용
const { data: product, refresh } = await useFetch(() => `https://fakestoreapi.com/products/${id.value}`);

console.log(product.value);

// 제품 가져오기 함수 정의
const fetchProduct = async () => {
  id.value++;  // ID 증가
  console.log('ID:', id.value);
  await refresh();  // 데이터 새로 고침
  console.log('Product:', product.value);
};
</script>
```

- ID -> ref
- useFetch 콜백함수 사용하여 동적 URL 생성
- fetchProduct 함수를 정의

### Why that?

- JavaScript 클로저 동작 때문에 useFetch가 처음 호출된 시점의 URL을 계속 사용하기 때문
- 콜백 함수를 사용하여 각 호출 시 새로운 URL을 생성함으로써 해결 가능

### DevTools

- Nuxt DevTools Payload섹션에서 데이터 확인
- F12 or Shift + Option + D

## 4. useFetch - De-duplication of requests

useFetch 컴포저블을 통해 Nuxt에서 어떻게 de-duplication(요청중복방지)하는가?

### 요청중복 방지(de-duplication)?

- 특정 엔드포인트에 대한 새로운 요청이 이전 요청 완료 전까지 방지되거나 지연되는 상황
- 동일한 리소스에 대해 여러 번 요청할 필요가 없도록 방지
- 서버 부하를 관리하고 효율성을 높이며 시스템이 예측 가능하게 동작하도록 도와줌

### Nuxt de-duplication

- 고유키를 사용하여 중복 방지
- URL과 옵션 매개변수에서 생성되며, 명시적으로 제공하지 않으면 자동 생성

```javascript
<template>
  <div>
    <button @click="fetchData">Get Product</button>
  </div>
</template>

<script setup>
import { useFetch } from '#app';

const { data: product, refresh } = await useFetch('https://fakestoreapi.com/products/1');

const fetchData = async () => {
  const interval = setInterval(async () => {
    await refresh();
  }, 1);

  setTimeout(() => clearInterval(interval), 2000);
};
</script>
```

- fetchData를 1밀리초마다 요청하지만 중복 요청을 방지하여 마지막 요청만 처리함

### 테스트 및 확인

- 네트워크 탭
  - 페이지 새로고침하고 요청 취소 확인
  - 버튼 클릭시 요청 중복 확인

- 콘솔로그
  - 요청 ID 증가 확인
  - 데이터가 여러번 로그되지만 요청은 한번만 이루어지는지 확인

## 5. useFetch - Adding a BaseURL

옵션 객체에 기본 URL 추가하기

```javascript
const axios = require('axios');

const options = {
  baseURL: 'https://example.com/api',
};

// 제품 목록 가져오기
axios.get('/products', options)
  .then(response => {
    console.log(response.data);
    // 제품 목록을 화면에 표시
  })
  .catch(error => {
    console.error('Error fetching products:', error);
});

// 카테고리 목록 가져오기
axios.get('/categories', options)
  .then(response => {
    console.log(response.data);
    // 카테고리 목록을 화면에 표시
  })
  .catch(error => {
    console.error('Error fetching categories:', error);
  });
```

- axios 옵션 객체에 baseURL속성을 추가하여 매개변수 전체에 URL을 작성하지 않도록 함
- 상대 경로만 사용하여 코드 가독성 향상

### POST, PUT, FETCH

- JSON Placeholder API
- `method`, `body`, `headers` 등을 설정
- JSON 형식의 문자열로 변환하여 `body`에 설정

### useFetch - Doing a POST Request

```javascript
const useFetch = require('use-fetch'); // useFetch를 사용하는 방법에 따라 다를 수 있습니다.

async function createPost() {
  const baseURL = 'https://jsonplaceholder.typicode.com';
  const endpoint = '/posts';

  const options = {
    method: 'POST',
    body: JSON.stringify({
      title: 'anything',
      body: 'hello world',
      userId: 1,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  };

  try {
    const response = await useFetch(endpoint, {
      baseURL: baseURL,
      ...options,
    });
    const data = await response.json();
    console.log(data);
    // Post 요청의 응답 데이터를 화면에 표시
  } catch (error) {
    console.error('Error creating post:', error);
  }
}

// createPost 함수를 호출하여 Post 요청을 보냅니다.
createPost();
```

### useFetch - Doing a PUT Request

```javascript
const useFetch = require('use-fetch'); // useFetch를 사용하는 방법에 따라 다를 수 있습니다.

async function updatePost() {
  const baseURL = 'https://jsonplaceholder.typicode.com';
  const endpoint = '/posts/1'; // ID가 1인 게시물을 업데이트합니다.

  const options = {
    method: 'PUT',
    body: JSON.stringify({
      title: 'Updated Title',
      body: 'Updating post with ID 1',
      userId: 1,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  };

  try {
    const response = await useFetch(endpoint, {
      baseURL: baseURL,
      ...options,
    });
    const data = await response.json();
    console.log(data);
    // 업데이트된 데이터를 화면에 표시
  } catch (error) {
    console.error('Error updating post:', error);
  }
}

// updatePost 함수를 호출하여 Put 요청을 보냅니다.
updatePost();
```

### useFetch - Doing a FETCH Request

```javascript
const useFetch = require('use-fetch'); // useFetch를 사용하는 방법에 따라 다를 수 있습니다.

async function patchPost() {
  const baseURL = 'https://jsonplaceholder.typicode.com';
  const endpoint = '/posts/1'; // ID가 1인 게시물의 제목을 업데이트합니다.

  const options = {
    method: 'PATCH',
    body: JSON.stringify({
      title: 'Patched Title',
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  };

  try {
    const response = await useFetch(endpoint, {
      baseURL: baseURL,
      ...options,
    });
    const data = await response.json();
    console.log(data);
    // 업데이트된 데이터를 화면에 표시
  } catch (error) {
    console.error('Error patching post:', error);
  }
}

// patchPost 함수를 호출하여 Patch 요청을 보냅니다.
patchPost()
```

## 6. useFetch - Adding query or params

### Alpha Vantage API 활용한 예제

```javascript
const useFetch = require('use-fetch'); // useFetch를 사용하는 방법에 따라 다를 수 있습니다.

async function fetchStockData() {
  const baseURL = 'https://www.alphavantage.co';
  const apiKey = 'YOUR_API_KEY_HERE'; // 여기에 실제 API 키를 넣으세요
  const endpoint = '/query';

  const options = {
    baseURL: baseURL,
    query: {
      function: 'TIME_SERIES_INTRADAY',
      symbol: 'IBM',
      interval: '5min',
      apikey: apiKey,
    },
  };

  try {
    const response = await useFetch(endpoint, options);
    const data = await response.json();
    console.log(data);
    // 주식 데이터를 화면에 표시
  } catch (error) {
    console.error('Error fetching stock data:', error);
  }
}

// fetchStockData 함수를 호출하여 주식 데이터를 가져옵니다.
fetchStockData();
```

- baseURL에는 Alpha Vantage API의 기본 URL을 설정
- apiKey에는 Alpha Vantage에서 발급받은 API 키를 저장
- endpoint는 요청할 API 경로
- options 객체에는 baseURL과 query 속성을 설정
- query 속성에는 요청 매개변수를 포함
- function: API 함수 이름 (예: 'TIME_SERIES_INTRADAY')
- symbol: 주식 심볼 (예: 'IBM')
- interval: 데이터 간격 (예: '5min')
- useFetch 함수에 엔드포인트와 옵션 객체를 전달하여 데이터를 가져옴

## 7. useFetch - Avoid fetching data on the server

- 데이터를 서버측에서 가져오지 않고 클라이언트 측에서만 가져오는 방법
  - 기본적으로 useFetch를 사용할 때 서버 측에서 API 요청이 실행됨
  - 데이터를 가져와 클라이언트로 전송한 후 클라이언트 측에서 다시 요청하지 않도록 설계됨
  - 경우에 따라 서버측에서 데이터를 가져오지 않고 클라이언트 측에서만 가져와야 하는 경우
  - `server: false` 추가

```javascrtip
const useFetch = require('use-fetch'); // useFetch를 사용하는 방법에 따라 다를 수 있습니다.

async function fetchData() {
  const baseURL = 'https://fakestoreapi.com';
  const endpoint = '/products/1'; // 예제 API 엔드포인트

  // 서버 측에서 데이터를 가져오지 않고 클라이언트 측에서만 가져오기 위해 server: false 설정
  const options = {
    baseURL: baseURL,
    server: false, // 기본값은 true이지만 false로 설정하여 클라이언트 측에서만 데이터를 가져옵니다.
  };

  try {
    const { data } = await useFetch(endpoint, options);
    console.log(data); // 클라이언트 측에서 데이터를 콘솔에 출력
  } catch (error) {
    console.error('Error fetching data:', error);
  }
}

// fetchData 함수를 호출하여 데이터를 가져옵니다.
fetchData();
```

기본 동작

- useFetch는 초기 로드 시 서버 측에서 실행
- 서버는 API 요청을 보내고 데이터를 받아 클라이언트로 전송
- 클라이언트 측에서 추가 요청 없이 데이터를 사용할 수 있음

클라이언트 측에서만 데이터 가져오기

- useFetch에 server: false 옵션을 추가하면 서버 측에서 데이터를 가져오지 않음
- 대신 클라이언트 측에서 데이터를 가져옴
- 초기 로드 시 서버 측에서 null을 반환하지만, 클라이언트 측에서는 API 요청이 실행되어 데이터를 가져옴

## 8. useFetch - lazy option

Nuxt 페이지에서 라우트로 이동할 때 데이터를 완전히 불러올 때까지 이동을 차단하는 기본 동작

```javascript
<!--index.vue-->
<template>
  <div>
    <h1>Home Page</h1>
    <nuxt-link to="/fetching">Fetching Page</nuxt-link>
  </div>
</template>
```

```javascript
<!--fetching.vue-->
<template>
  <div>
    <h1 v-if="pending">Loading...</h1>
    <div v-else>
      <h1>Product Data</h1>
      <p>{{ product }}</p>
    </div>
  </div>
</template>

<script>
export default {
  async setup() {
    // 데이터 가져오기
    const { data: product, pending } = await useFetch('/api/product', {
      lazy: true // lazy 옵션을 true로 설정하여 페이지 이동을 차단하지 않음
    });

    return {
      product,
      pending
    };
  }
};
</script>
```

- `lazy: true`
- `useFetch`반환값에서 `pending`을 추출하고 false가 되었을 때 데이터 표시
- 동작 설명
  - 홈 페이지에서 Fetching Page 링크를 클릭하면 /fetching 페이지로 이동
  - pending이 true인 동안 "Loading..." 메시지가 표시
  - 데이터가 도착하면 pending이 false로 변경되고, 실제 데이터가 화면에 표시

## 9. useFetch - immediate option

`immediate: false`로 설정하여 원하는 시점에 데이터를 가져옴

```javascript
<!--fetching.vue-->
<template>
  <div>
    <h1>Product Data</h1>
    <button @click="execute">Display Data</button>
    <div v-if="pending">Loading...</div>
    <div v-else-if="product">
      <p>{{ product }}</p>
    </div>
  </div>
</template>

<script>
export default {
  async setup() {
    // 데이터 가져오기
    const { data: product, pending, execute } = await useFetch('/api/product', {
      immediate: false // 즉시 데이터를 가져오지 않도록 설정
    });

    return {
      product,
      pending,
      execute
    };
  }
};
</script>
```

- `immediate: false`를 추가
- 데이터를 가져오는 `execute` 함수를 추출하여 버튼 클릭 시 실행
- 버튼을 추가하고 클릭 이벤트에 `execute` 함수를 연결
- 동작 설명
  - immediate: false로 설정되어 있어 데이터가 즉시 로드되지 않음
  - 버튼을 클릭하면 execute 함수가 실행되어 데이터를 가져옴
  - 데이터가 로드되는 동안 "Loading..." 메시지가 표시
  - 데이터가 로드되면 "Product Data"와 함께 데이터를 화면에 표시

## 10. useFetch - default option

- `default`옵션을 사용하여 데이터를 가져오기 전 기본값 설정하는 방법
- 데이터가 도착하기 전 사용자에게 기본 메시지를 표시

```javascript
<template>
  <div>
    <h1>Product Data</h1>
    <button @click="execute">Display Data</button>
    <div v-if="pending">Loading...</div>
    <div v-else-if="product">
      <p>{{ product }}</p>
    </div>
  </div>
</template>

<script>
export default {
  async setup() {
    // 데이터 가져오기
    const { data: product, pending, execute } = await useFetch('/api/product', {
      immediate: false, // 즉시 데이터를 가져오지 않도록 설정
      default: () => 'No data available' // 기본 값을 설정하는 함수
    });

    return {
      product,
      pending,
      execute
    };
  }
};
</script>
```

- `immediate: false`로 설정
- 기본 값을 설정하는 `default`함수로 No data available 메시지를 반환
- 버튼 클릭 시 `execute` 함수가 실행되어 데이터를 가져옴
- 동작 설명
  - 페이지를 로드하면 default 옵션으로 설정된 기본 값 No data available가 표시
  - 버튼을 클릭하면 execute 함수가 실행되어 데이터를 가져옴
  - 데이터가 로드되는 동안 "Loading..." 메시지가 표시
  - 데이터가 로드되면 기본 값이 실제 데이터로 대체
