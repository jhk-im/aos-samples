# Nuxt basic

- npm
- Vue officail extensions
- nuxt.config.ts
- Nuxt DevTools
  - Nuxt 3.1.0 이상
  - nuxt.config.ts
    - devToolsEnabled: true
    - 브라우저에서 Nuxt 개발도구 아이콘 클릭
  - 디버깅 및 개발기능 제공
  - 컴포넌트 개수, 패널, API 페이로드 등등
- app.vue
  - 애플리케이션 진입점

## 1.Components

- 사용자 인터페이스 조각
- components 디렉토리에 생성
- 명시적으로 가져오지 않아도 애플리케이션 전반에 걸쳐 자동으로 사용 가능

## 2.Routing

[Routing Example](https://github.com/ProgrammingFluency/NuxtJS-Fluency-The-Premier-NUXT-3-Masterclass/tree/main/02-NuxtJS%20Fundamentals%20%5BPart%201%5D%20(Installation%2C%20Views%2C%20Routing%2C%20Styling%20and%20more...)/Routing%20%5BNavigation%5D)

- pages 디렉토리에 생성
- Nuxt 페이지는 단일 루트 요소가 있어야함
  - Nuxt가 페이지 전환을 수행할 수 있게하는 요소
  - HTML 주석 요소로 간주됨
  - div위에 h1을 만들면 안됨
  - Nuxt가 라우팅을 수행할 수 없게됨

```html
<template>
    <div>
        <h1>About page</h1>
    </div>
</template>
```

### NuxtLink `<a>`의 차이점

- NuxtLink는 이미 로드된 라우트를 인지하고 적절히 컴포넌트를 교체함
- 일반링크를 사용하면 새로운 서버 요청이 발생함
- 일반링크는 클래스가 없어 수동으로 클래스를 추가해야 함
- 페이지가 활성 상태일 때 스타일을 자동으로 적용할 수 있게 해주는 유용한 기능

### 동적 라우팅

- 동적 파라미터 사용
  - pages에 파일 이름을 `[id].vue` 형식으로 설정하면 해당 id가 동적 값으로 처리됨
- 라우트 파라미터 추출
  - script에서 `useRoute()`함수를 사용하여 라우트에서 파라미터 추출
  - 현재 보고있는 라우트에 대한 모든 정보를 포함하는 객체 반환
- 템플릿에서 ID 표시
  - `h1` 태그를 사용하여 id 표시
- 동적 라우트 테스트
  - `localhost:3000/123`으로 접속시 동적으로 추출
- 중첩라우트 생성
  - users라는 폴더에 `[name]`형식의 폴더생성후 내부에 `[id].vue`파일 생성
  - name과 id 동적으로 추출
  - `localhost:3000/nor/123`
- 부분 동적 라우트
  - andmins폴더에 `admins-[name]`형식의 폴더 생성 후 내부에 `[id].vue` 파일 생성
  - `localhost:3000/admins-mark/50`

### 루트 매개변수 추출

- `[id].vue` 파일 내부 스크립트에 다음과 같이 정의

```vue
<template>
  <h1>{{ $route.params.id }}</h1>
</template>

<script setup>
// 스크립트 설정 부분은 이 경우 특별히 필요한 코드가 없습니다.
</script>
```

- `$route`객체를 직접 사용하여 현재 라우트의 매개변수에 직접 접근
- `$route.params.id`를 통해 현재 라우트의 ID 매개변수 값을 템플릿에서 직접 참조
  - 이 방식은 코드를 직관적이고 간단하게 유지할 수 있음

### 특정 경로 이후의 모든 라우트 가져오기

- 파일생성
  - `pages` 디렉토리에 `[...words].vue`형식으로 생성
- 스크립트 설정

```vue
<script setup>
import { useRoute } from 'vue-router';

const route = useRoute();
const words = route.params.words; // 'words'는 경로의 모든 세그먼트를 포함하는 배열
</script>

```

- 템플릿에 배열 표시

```vue
<template>
  <p>{{ words.join(' ') }}</p> <!-- 배열의 모든 요소를 공백으로 구분하여 문자열로 결합하여 표시합니다. -->
</template>
```

- 라우트 테스트
  - `localhost:3000/home/hey/guys/good/day`와 같이 접속하면 모든 경로의 세그먼트가 페이지에 표시됨

## 3.Route Middleware

[Middleware Example](https://github.com/ProgrammingFluency/NuxtJS-Fluency-The-Premier-NUXT-3-Masterclass/tree/main/02-NuxtJS%20Fundamentals%20%5BPart%201%5D%20(Installation%2C%20Views%2C%20Routing%2C%20Styling%20and%20more...)/Routing%20%5BRoute%20middleware%20(Part%201)%5D)

- Inline middleware
  - 특정 페이지 내부에 직접 정의
  - about.vue 내부에 작성하면 해당 페이지로 이동하기 전에 실행됨
- In middleware directory
  - middleware 디렉토리 내에 파일로 저장하고, 필요한 페이지에서 참조하여 사용
- Global middleware
  - middleware 디렉토리에 .global 파일을 추가하여 전역적으로 사용
  - 모든 라우트 이동 시 실행

### Inline middleware

```javascript
<script setup>
import { definePageMeta } from 'nuxt'

definePageMeta({
  middleware: [
    (to, from) => {
      console.log('Navigating from:', from.path, 'to:', to.path)
      console.log('This code will run before navigating to the about route')
    }
  ]
})
</script>
```

- script setup을 사용하여 definePageMeta호출
  - definePageMeta는 미들웨어를 배열 형태로 받는 middleware 속성을 포함한 객체를 인자로 받음
  - to, form 두 매개변수를 받아 현재/이전 라우트의 정보를 제공받음
- 위 코드를 통해 about페이지로 이동할 때마다 콘솔에 이전/현재 라우트 정보가 출력됨

### In middleware directory

```javascript
// middleware/example.js
<script setup>
import { definePageMeta } from 'nuxt'

definePageMeta({
  middleware: [
    (to, from) => {
      console.log('Navigating from:', from.path, 'to:', to.path)
      console.log('This code will run before navigating to the about route')
    }
  ]
})
</script>

// about.vue
<script setup>
import { definePageMeta } from 'nuxt'

definePageMeta({
  middleware: ['example']
})
</script>
```

- middleware 디렉토리에 example.js 파일생성
- about.vue 페이지에서 middleware를 참조하여 사용

### Global middleware

```javascript
// middleware/.global.js
export default function (to, from) {
  console.log('This code will run before navigating to each route')
}
```

- 파일 이름에 .global.js를 추가하여 전역적으로 사용
- 모든 페이지 이동전에 실행

### Middleware 속성

- 호출순서는 Global -> Inline -> File
- 전역 미들웨어의 순서는 파일명을 알파벳 순으로 정렬함
  - 01.golbal.js, 02.global.js

### Middleware 적용

```javascript
// middleware/check-user-id.js
export default defineNuxtRouteMiddleware((to, from, next) => {
  const userId = to.params.id;
  if (userId === '1') {
    // ID가 1이면 홈으로 리디렉션
    return next({ path: '/' });
  } else if (userId === '2') {
    // ID가 2이면 내비게이션 중단
    return next(false);
  } else if (userId === '3') {
    // ID가 3이면 내비게이션 중단 및 오류 메시지 표시
    return next(Error('ID shouldn\'t be 3'));
  } else {
    console.log('Everything is fine');
    // 그 외의 경우 정상적으로 라우트 이동
    return next();
  }
});
```

### Dymamic middleware

- addRouteMiddleware

```javascript
// plugins/my-plugin.js
export default defineNuxtPlugin( () => {
   // 익명 미들웨어 추가
    addRouteMiddleware( (to, from) => {
        if(to.path === '/database') {
            return abortNavigation('Forbidden')
        }
    })

  // 이름이 지정된 미들웨어 추가
    addRouteMiddleware('denyNoor', (to, from) => {
        const name = to.params.name
        if(name === 'noor') return abortNavigation('The name noor is not allowed')
    })
  
  // 전역 미들웨어 추가
    addRouteMiddleware(() => {
        console.log('Global middleware')
    }, {global: true})
})
```

### Middleware Quiz

How can you access the route object within middleware?

라우트 객체를 사용하여 다양한 라우트 정보를 얻을 수 있습니다. to 객체와 from 객체는 Vue Router의 RouteLocationNormalized 타입을 따르며, path, name, params, query 등의 속성을 포함합니다.

```javascript
// 다음은 users/[name].vue 파일을 생성하고 denyNoor 미들웨어를 사용하는 예입니다. 
// 여기서 to.params를 통해 동적 라우트 파라미터 name에 접근합니다.
<template>
  <div>
    <h1>User Name: {{ $route.params.name }}</h1>
  </div>
</template>

<script setup>
definePageMeta({
  middleware: ['denyNoor']
});
</script>
```

What happens if a middleware function returns false?

Nuxt 3에서 미들웨어 함수가 false를 반환하면, 해당 라우트로의 내비게이션이 중단됩니다. 이는 내비게이션을 명시적으로 취소하는 방법으로 사용할 수 있습니다.

## 4.Route Validation

동적 라우트 유효성 검사를 설정하여, 특정 조건을 만족하지 않는 경우 에러 페이지를 표시함

```javascript
// [id].vue
<template>
  <div>
    <h1>User ID: {{ id }}</h1>
  </div>
</template>

<script setup>
// 객체를 가져와 prams.id를 추출
import { useRoute } from 'vue-router';

const route = useRoute();
const id = route.params.id;

// definePageMeta를 사용하여 validate 속성에 비동기 함수 설정
// id가 숫자로만 이루어 졌는지 확인
definePageMeta({
  validate: async (r) => {
    return /^\d+$/.test(r.params.id);
  }
});
</script>
```

- 프로젝트를 실행하고 다음과 같은 URL을 통해 결과확인
  - 유효한 ID (숫자만 포함): /123와 같은 경로로 이동하면 해당 ID가 표시됨
  - 유효하지 않은 ID (숫자가 아닌 문자 포함): /123a와 같은 경로로 이동하면 에러 페이지가 표시됨
- definePageMeta 함수의 validate 속성을 사용하여 유효성 검사를 수행할 수 있음

## 5.Layout

- 여러 페이지에 걸쳐 공통으로 사용되는 사용자 인터페이스 요소(헤터, 푸터 등)를 관리하기 위해 레이아웃을 생성할 수 있음

### 설정

- layouts/default.vue, layouts/custom.vue 등

```javascript
// default.vue
<template>
  <div>
    <h1>Default Layout Header</h1>
    <slot></slot>
    <footer>Default Layout Footer</footer>
  </div>
</template>

<script setup>
// 추가적인 스크립트 로직이 필요한 경우 여기에 작성
</script>

// custom.vue
<template>
  <div>
    <h1>This is Custom Layout</h1>
    <slot></slot>
    <p>Another Custom Layout Content</p>
  </div>
</template>

<script setup>
// 추가적인 스크립트 로직이 필요한 경우 여기에 작성
</script>
```

### 레이아웃 적용

- layouts 디렉토리에 default.vue 생성하면 자동으로 모든 페이지에 적용됨
- 특정 페이지에서 사용자 정의 레이아웃을 사용하기위해 'definePageMeta'를 사용하여 레이아웃 지정

```javascript
<template>
  <div>
    <h1>User Name: {{ $route.params.name }}</h1>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'custom'
});
</script>
```

- 레이아웃 동적 변경

```javascript
<!-- pages/index.vue -->
<template>
  <div>
    <button @click="enableCustomLayout">Change Layout</button>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useNuxtApp } from '#app';

const nuxtApp = useNuxtApp();
const enableCustomLayout = () => {
  nuxtApp.$page.setLayout('custom');
};
</script>
```

- 레이아웃 비활성화

```javascript
<!-- pages/about.vue -->
<template>
  <div>
    <h1>About Page</h1>
  </div>
</template>

<script setup>
definePageMeta({
  layout: false
});
</script>
```

- NuxtApp

```javascript
<!-- app.vue -->
<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
```

- 다양한 페이지에 공통된 구조를 적용
- 유지 보수성과 일관성을 크게 향상

## 6.Lazy Loading

- 중요한 리소스만 먼저 로드하고 다른 리소스는 필요할 때까지 로드를 지연시킴
- 이미지, 스크립트, 컴포넌트와 같은 비핵심 리소스의 로딩을 지연시킴
- 초기 로딩시간 개선
- dynamic imports

### example

- 컴포넌트 생성

```javascript
<!-- components/Welcome.vue -->
<template>
  <div>
    <h1>Welcome to Nuxt 3!</h1>
  </div>
</template>

<script setup>
// 추가 스크립트가 필요하지 않음
</script>
```

- 지연 로딩 구현
- Welcome 컴포넌트 지연 로딩

```javascript
<!-- pages/index.vue -->
<template>
  <div>
    <button @click="toggleShow">Show Welcome Message</button>
    <Suspense>
      <template #default>
        <LazyWelcome v-if="show" />
      </template>
      <template #fallback>
        <div>Loading...</div>
      </template>
    </Suspense>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const show = ref(false);

const toggleShow = () => {
  show.value = !show.value;
};

// Lazy load the component
const LazyWelcome = defineAsyncComponent(() => import('@/components/Welcome.vue'));
</script>
```

- ref를 사용하여 show 상태를 정의
- toggleShow함수를 통해 show 상태 토글
- Suspense 컴포넌트를 사용하여 비동기 컴포넌트 로딩중 스피너 또는 메세지 표시
- defineAsyncComponent를 사용하여 Welcome 컴포넌트를 동적으로 가져옴
- 버튼을 클릭하면 Welcome.vue가 동적으로 표시됨

## 7.Assets

- 스타일 시트, 폰트, JavaScript파일, 이미지 등 다양한 자산을 관리함
- public, assets디렉토리 제공
  - public은 정적 파일을 서버 루트에서 제공하며 빌드도구에 의해 처리되지 않음
  - assets은 정적 파일을 빌드 도구를 통해 처리하여 최적화, 해싱등을 수행

```zsh
mkdir -p public/images
# Google 이미지에서 다운받은 Nuxt.js 로고 추가
cp path/to/downloaded/nuxt.png public/images/nuxt.png

mkdir -p assets/images
# Google 이미지에서 다운받은 Nuxt.js 로고 추가
cp path/to/downloaded/nuxt.png assets/images/nuxt.png
```

```javascript
// 이미지 사용
<!-- pages/index.vue -->
<template>
  <div>
    <img :src="publicImageSrc" alt="Nuxt Image from Public" />
    <img :src="assetsImageSrc" alt="Nuxt Image from Assets" />
  </div>
</template>

<script setup>
const publicImageSrc = '/images/nuxt.png';
const assetsImageSrc = '/_nuxt/assets/images/nuxt.png';
</script>

<style scoped>
img {
  width: 80px;
  height: 80px;
}
</style>
```

## 8.Nuxt Styling

vue 단일 컴포넌트, 외부 CSS 라이브러리, 사용자 정의 CSS 파일 등 다양한 방법으로 애플리케이션을 스타일링함

### 단일 컴포넌트 인라인 스타일링

```javascript
// scoped 속성을 사용하여 특정 컴포넌트에만 스타일을 적용
<!-- pages/index.vue -->
<template>
  <div>
    <h1>Hello Nuxt.js!</h1>
  </div>
</template>

<style scoped>
h1 {
  color: red;
}
</style>
```

### 사용자 정의 CSS파일

```zsh
mkdir -p assets/styles
touch assets/styles/style.css
```

```css
/* assets/styles/style.css */
h1 {
  color: red;
}
```

``` javascript
//  CSS 파일 임포트
<!-- pages/index.vue -->
<template>
  <div>
    <h1>Hello Nuxt.js!</h1>
  </div>
</template>

<script setup>
import '@/assets/styles/style.css';
</script>
```

### 외부 CSS 라이브러리 사용

```zsh
npm install animate.css
```

```javascript
// nuxt.config.js 수정
export default {
  css: [
    'animate.css'
  ]
}
```

```javascript
// 클래스 적용
<!-- pages/index.vue -->
<template>
  <div>
    <h1 class="animate__animated animate__bounce">Hello Nuxt.js!</h1>
  </div>
</template>
```

### Tailwind CSS

```zsh
npm install -D @nuxtjs/tailwindcss
```

```javascript
// nuxt.config.js 파일을 수정
export default {
  modules: [
    '@nuxtjs/tailwindcss'
  ]
}
```

```javascript
// Tailwind CSS 사용
<!-- pages/index.vue -->
<template>
  <div>
    <h1 class="text-4xl font-bold text-blue-500">Hello Nuxt.js!</h1>
  </div>
</template>
```

### Flowbite

- Flowbite는 Tailwind CSS 위에 구축된 UI 컴포넌트 라이브러리

```zsh
npm install flowbite
```

```javascript
// Tailwind CSS 설정 파일(tailwind.config.js)을 수정하여 Flowbite를 포함
// tailwind.config.js
module.exports = {
  content: [
    './node_modules/flowbite/**/*.js',
    './pages/**/*.{vue,js}',
    './components/**/*.{vue,js}',
    './layouts/**/*.{vue,js}',
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('flowbite/plugin')
  ],
}

```

```javascript
// Tailwind CSS 사용
<!-- pages/index.vue -->
<template>
  <div>
    <nav class="bg-gray-800 p-4">
      <div class="container mx-auto">
        <a class="text-white" href="#">Home</a>
        <a class="text-gray-400 ml-4" href="#">About</a>
      </div>
    </nav>
  </div>
</template>

```

## SEO and Metadata

각 페이지별로 메타데이터를 설정하거나 전역 설정을 할 수 있음

### nuxt.config.js 전역설정

- 모든 페이지에 공통 적용

```javascript
// nuxt.config.js
export default {
  app: {
    head: {
      charset: 'utf-8',
      viewport: 'width=device-width, initial-scale=1.0',
      title: 'Nuxt App',
      meta: [
        { name: 'description', content: 'Nuxt Course' }
      ],
      link: [
        { rel: 'stylesheet', href: '/assets/styles/style.css' }
      ]
    }
  }
}
```

### 개별 페이지 메타데이터 설정

```javascript
// useHead
<!-- pages/about.vue -->
<template>
  <div>
    <h1>About Page</h1>
  </div>
</template>

<script setup>
import { useHead } from '#app';

useHead({
  title: 'About Page',
  meta: [
    { name: 'description', content: 'This is the about page' }
  ]
});
</script>

// useSeoMeta
<!-- pages/about.vue -->
<template>
  <div>
    <h1>About Page</h1>
  </div>
</template>

<script setup>
import { useSeoMeta } from '#app';

useSeoMeta({
  title: 'My About Page',
  description: 'This is the about page'
});
</script>
```

### 컴포넌트 메타데이터 설정

- Head 컴포넌트 활용

```javascript
<!-- pages/about.vue -->
<template>
  <div>
    <Head>
      <title>About Page from Components</title>
      <meta name="description" content="This is the about page using components" />
    </Head>
    <h1>About Page</h1>
  </div>
</template>

<script setup>
import { Head } from '#app';
</script>
```

### 동적 페이지 메타데이터 설정

- URL 파라미터에 따라 제목을 동적으로 설정

```javascript
<!-- pages/[name].vue -->
<template>
  <div>
    <Head>
      <title>{{ route.params.name }}</title>
    </Head>
    <h1>{{ route.params.name }}</h1>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router';
import { Head } from '#app';

const route = useRoute();
</script>
```

### 메타데이터 동적 변경

- 버튼 클릭 등의 이벤트에 따라 동적으로 변경

```javascript
<!-- pages/index.vue -->
<template>
  <div>
    <Head>
      <title>{{ counter }}</title>
    </Head>
    <h1>{{ counter }}</h1>
    <button @click="incrementCounter">Increment</button>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { Head } from '#app';

const counter = ref(1);
const incrementCounter = () => {
  counter.value++;
};
</script>
```

- 다양한 옵션을 사용하여 SEO 최적화 구축

## Transition

페이지 전환 애니메이션 설정

### 페이지 간 전환 설정

- pageTransition 속성을 사용하여 페이지 간 전환 애니메이션을 설정

```javascript
// nuxt.config.js
export default {
  app: {
    pageTransition: {
      name: 'page',
      mode: 'out-in'
    }
  }
}
```

### 전환 애니메이션 스타일링

- 스타일 추가

```javascript
<!-- pages/index.vue -->
<template>
  <div>
    <h1>Home Page</h1>
    <nuxt-link to="/about">About Page</nuxt-link>
  </div>
</template>

<style>
.page-enter-active, .page-leave-active {
  transition: all 0.4s;
}

.page-enter-from, .page-leave-to {
  opacity: 0;
  filter: blur(1rem);
}
</style>
```

### 레이아웃 전환 설정

- layoutTransition 속성을 설정하고 스타일링 수정

```javascript
// nuxt.config.js
export default {
  app: {
    layoutTransition: {
      name: 'layout',
      mode: 'out-in'
    }
  }
}
```

```javascript
<!-- layouts/default.vue -->
<template>
  <div>
    <h1>Default Layout</h1>
    <slot />
  </div>
</template>

<!-- layouts/custom.vue -->
<template>
  <div>
    <h1>Custom Layout</h1>
    <slot />
  </div>
</template>

// custom 레이아웃 사용하도록 설정
<!-- pages/about.vue -->
<template>
  <div>
    <h1>About Page</h1>
    <nuxt-link to="/">Home Page</nuxt-link>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'custom'
});
</script>

// index.vue, about.vue 파일에 스타일 추가
// 전환애니메이션 스타일링
<!-- pages/index.vue -->
<template>
  <div>
    <h1>Home Page</h1>
    <nuxt-link to="/about">About Page</nuxt-link>
  </div>
</template>

<style>
.layout-enter-active, .layout-leave-active {
  transition: all 0.4s;
}

.layout-enter-from, .layout-leave-to {
  opacity: 0;
  filter: blur(1rem);
}
</style>
```
