# 物联网设备管理系统

## 项目简介

物联网设备管理系统是一个基于Flutter开发的跨平台移动应用，旨在帮助用户轻松管理和监控其物联网（IoT）设备。通过直观的用户界面，用户可以注册和登录账户、查看设备列表、管理设备详情以及分析设备产生的数据。本项目适合希望学习Flutter应用开发及物联网设备管理的初学者和开发者。

## 功能特性

1. **用户认证**
   - 用户注册与登录
   - 表单验证与错误处理

2. **设备管理**
   - 查看所有已注册的设备
   - 添加新设备
   - 查看设备详情
   - 删除或编辑设备信息

3. **数据分析**
   - 查看设备产生的数据
   - 数据表格展示
   - 支持数据的排序与筛选

4. **用户界面**
   - 现代化设计与一致的风格
   - 渐变背景与卡片式布局
   - 响应式设计，适配不同屏幕尺寸

## 技术栈

- [Flutter](https://flutter.dev/) - 用于构建跨平台移动应用
- [Dart](https://dart.dev/) - Flutter的编程语言
- [HTTP](https://pub.dev/packages/http) - 处理网络请求
- [JSON](https://dart.dev/guides/json) - 数据交换格式
- [Material Design](https://material.io/design) - UI设计语言

## 安装与运行

### 前提条件

- **Flutter SDK**: 确保已安装Flutter SDK。安装指南见[官方文档](https://flutter.dev/docs/get-started/install)。
- **开发工具**: 推荐使用[Android Studio](https://developer.android.com/studio)或[Visual Studio Code](https://code.visualstudio.com/)。
- **设备或模拟器**: 配置Android或iOS设备，或使用模拟器/仿真器。
- **后端API**: 确保有可用的后端API端点，用于用户认证和设备管理。

### 安装步骤

1. **克隆仓库**

   ```bash
   git clone https://github.com/HT3301601278/WDY.git
   cd 物联网设备管理系统
   ```

2. **安装依赖**

   ```bash
   flutter pub get
   ```

3. **配置API常量**

   在 `lib/utils/constants.dart` 文件中，配置API的 `baseUrl` 和 `token`。

   ```dart
   class ApiConstants {
     static const String baseUrl = 'https://api.example.com'; // 替换为您的API端点
     static String token = ''; // 用户登录后设置
   }
   ```

4. **运行应用**

   连接设备或启动模拟器，然后运行：

   ```bash
   flutter run
   ```

## 项目结构

```
lib/
├── main.dart
├── models/
│   └── device.dart
├── screens/
│   ├── login_register_screen.dart
│   ├── device_management_screen.dart
│   ├── device_detail_screen.dart
│   └── data_analysis_screen.dart
├── services/
│   ├── auth_service.dart
│   └── device_service.dart
├── utils/
│   └── constants.dart
└── widgets/
    ├── login_form.dart
    └── register_form.dart
```

- **main.dart**: 应用入口，配置路由与主题。
- **models/**: 数据模型，如 `Device`。
- **screens/**: 各个页面的实现，包括登录、设备管理、设备详情和数据分析。
- **services/**: 与后端API交互的服务类。
- **utils/**: 常量与工具类。
- **widgets/**: 可复用的组件，如登录和注册表单。

## 详细说明

### 1. 主程序入口 (`main.dart`)

主程序入口定义了应用的基本主题和路由。

**说明:**

- **主题配置**: 设置应用的主色调、输入框样式和按钮样式，确保整个应用的一致性。
- **路由配置**:
  - **初始路由**: `/` 对应 `LoginRegisterScreen` 登录/注册页面。
  - **设备管理路由**: `/devices` 对应 `DeviceManagementScreen` 设备管理页面，如果用户未登录（`token` 为空），则重定向到登录页面。

### 2. 登录和注册页面 (`login_register_screen.dart`)

该页面包含了登录和注册功能，用户可以在两者之间切换。

**主要组件:**

- **LoginForm**: 登录表单
- **RegisterForm**: 注册表单

**样式特点:**

- 使用卡片式设计和渐变背景，提供良好的视觉体验。
- 表单验证与错误处理，确保用户输入的有效性。

### 3. 设备管理页面 (`device_management_screen.dart`)

设备管理页面显示了用户所有的设备列表，并提供了添加新设备的功能。

**主要功能:**

- **查看设备列表**: 以卡片形式展示设备名称、MAC地址和通信通道。
- **添加新设备**: 通过弹出对话框输入设备信息。
- **查看设备详情**: 点击设备卡片进入设备详细信息页面。

### 4. 设备详情页面 (`device_detail_screen.dart`)

设备详情页面展示单个设备的详细信息，并提供查看数据分析的功能。

**主要功能:**

- **查看设备信息**: 包括设备ID、MAC地址和通信通道。
- **查看数据分析**: 导航到数据分析页面，查看设备产生的数据。

**样式特点:**

- 使用卡片式布局和渐变背景，保持与其他页面的一致性。
- 使用图标增强信息展示。

### 5. 数据分析页面 (`data_analysis_screen.dart`)

数据分析页面展示设备产生的数据，使用 `DataTable` 进行清晰的数据展示。

**主要功能:**

- **查看设备数据**: 包括序号、值和时间。
- **数据表格展示**: 支持水平和垂直滚动，适配不同数据量。

**样式特点:**

- 使用卡片式布局和渐变背景，保持与其他页面的一致性。
- 表格行采用交替颜色，增强可读性。

### 6. 服务类

**1. AuthService (`auth_service.dart`)**

处理用户认证相关的API请求，包括登录和注册。

**2. DeviceService (`device_service.dart`)**

处理设备相关的API请求，包括获取所有设备和注册新设备。

### 7. 数据模型

**Device 模型 (`device.dart`)**

定义设备的数据结构。

**User 模型 (`user.dart`)**

定义用户的数据结构。

### 8. 工具类

**常量文件 (`constants.dart`)**

存储应用中使用的常量，如API端点和用户Token。

### 9. 小部件

**登录表单 (`login_form.dart`)**

实现用户登录表单。

**注册表单 (`register_form.dart`)**

实现用户注册表单。

## API文档

### 基础URL

所有API请求的基础URL为：`http://localhost:8000`

### 认证

大多数API端点需要认证。认证通过在请求头中包含一个有效的JWT令牌来实现。

认证头格式：`Authorization: Bearer <your_jwt_token>`

### API端点

#### 1. 用户注册

- **URL**: `/api/auth/register`
- **方法**: POST
- **描述**: 注册新用户
- **请求体**:
  ```json
  {
    "username": "string",
    "email": "string",
    "password": "string"
  }
  ```
- **成功响应**: 
  - 状态码: 201
  - 响应体:
    ```json
    {
      "id": "string",
      "username": "string",
      "email": "string"
    }
    ```
- **错误响应**:
  - 状态码: 400
  - 响应体:
    ```json
    {
      "detail": "错误信息"
    }
    ```

**测试用例**:
1. 使用有效的用户名、邮箱和密码注册
2. 尝试使用已存在的用户名或邮箱注册
3. 尝试使用无效的邮箱格式注册
4. 尝试使用过短的密码注册

#### 2. 用户登录

- **URL**: `/api/auth/login`
- **方法**: POST
- **描述**: 用户登录并获取JWT令牌
- **请求体**:
  ```json
  {
    "username": "string",
    "password": "string"
  }
  ```
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "access_token": "string",
      "token_type": "bearer"
    }
    ```
- **错误响应**:
  - 状态码: 401
  - 响应体:
    ```json
    {
      "detail": "Incorrect username or password"
    }
    ```

**测试用例**:
1. 使用正确的用户名和密码登录
2. 使用错误的用户名登录
3. 使用错误的密码登录
4. 使用不存在的用户名登录

#### 3. 获取当前用户信息

- **URL**: `/api/users/me`
- **方法**: GET
- **描述**: 获取当前登录用户的信息
- **认证**: 需要
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "id": "string",
      "username": "string",
      "email": "string"
    }
    ```
- **错误响应**:
  - 状态码: 401
  - 响应体:
    ```json
    {
      "detail": "Not authenticated"
    }
    ```

**测试用例**:
1. 使用有效的JWT令牌获取用户信息
2. 使用无效的JWT令牌尝试获取用户信息
3. 不提供JWT令牌尝试获取用户信息

#### 4. 创建新的待办事项

- **URL**: `/api/todos`
- **方法**: POST
- **描述**: 创建一个新的待办事项
- **认证**: 需要
- **请求体**:
  ```json
  {
    "title": "string",
    "description": "string",
    "due_date": "2023-05-20T12:00:00Z"
  }
  ```
- **成功响应**: 
  - 状态码: 201
  - 响应体:
    ```json
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "is_completed": false,
      "due_date": "2023-05-20T12:00:00Z",
      "created_at": "2023-05-18T10:30:00Z",
      "updated_at": "2023-05-18T10:30:00Z"
    }
    ```
- **错误响应**:
  - 状态码: 400
  - 响应体:
    ```json
    {
      "detail": "错误信息"
    }
    ```

**测试用例**:
1. 创建一个有效的待办事项
2. 尝试创建一个没有标题的待办事项
3. 尝试创建一个过去日期的待办事项
4. 创建一个只有标题没有描述的待办事项

#### 5. 获取所有待办事项

- **URL**: `/api/todos`
- **方法**: GET
- **描述**: 获取当前用户的所有待办事项
- **认证**: 需要
- **查询参数**:
  - `completed`: boolean (可选，筛选已完成或未完成的待办事项)
  - `page`: integer (可选，默认为1)
  - `per_page`: integer (可选，默认为10)
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "items": [
        {
          "id": "string",
          "title": "string",
          "description": "string",
          "is_completed": boolean,
          "due_date": "2023-05-20T12:00:00Z",
          "created_at": "2023-05-18T10:30:00Z",
          "updated_at": "2023-05-18T10:30:00Z"
        }
      ],
      "total": integer,
      "page": integer,
      "per_page": integer
    }
    ```
- **错误响应**:
  - 状态码: 401
  - 响应体:
    ```json
    {
      "detail": "Not authenticated"
    }
    ```

**测试用例**:
1. 获取所有待办事项
2. 获取已完成的待办事项
3. 获取未完成的待办事项
4. 使用分页参数获取待办事项

#### 6. 获取单个待办事项

- **URL**: `/api/todos/{todo_id}`
- **方法**: GET
- **描述**: 获取指定ID的待办事项
- **认证**: 需要
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "is_completed": boolean,
      "due_date": "2023-05-20T12:00:00Z",
      "created_at": "2023-05-18T10:30:00Z",
      "updated_at": "2023-05-18T10:30:00Z"
    }
    ```
- **错误响应**:
  - 状态码: 404
  - 响应体:
    ```json
    {
      "detail": "Todo not found"
    }
    ```

**测试用例**:
1. 获取一个存在的待办事项
2. 尝试获取一个不存在的待办事项
3. 尝试获取属于其他用户的待办事项

#### 7. 更新待办事项

- **URL**: `/api/todos/{todo_id}`
- **方法**: PUT
- **描述**: 更新指定ID的待办事项
- **认证**: 需要
- **请求体**:
  ```json
  {
    "title": "string",
    "description": "string",
    "is_completed": boolean,
    "due_date": "2023-05-20T12:00:00Z"
  }
  ```
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "is_completed": boolean,
      "due_date": "2023-05-20T12:00:00Z",
      "created_at": "2023-05-18T10:30:00Z",
      "updated_at": "2023-05-19T11:00:00Z"
    }
    ```
- **错误响应**:
  - 状态码: 404
  - 响应体:
    ```json
    {
      "detail": "Todo not found"
    }
    ```

**测试用例**:
1. 更新一个待办事项的标题
2. 将一个待办事项标记为已完成
3. 更新一个待办事项的截止日期
4. 尝试更新一个不存在的待办事项

#### 8. 删除待办事项

- **URL**: `/api/todos/{todo_id}`
- **方法**: DELETE
- **描述**: 删除指定ID的待办事项
- **认证**: 需要
- **成功响应**: 
  - 状态码: 204
  - 响应体: 无
- **错误响应**:
  - 状态码: 404
  - 响应体:
    ```json
    {
      "detail": "Todo not found"
    }
    ```

**测试用例**:
1. 删除一个存在的待办事项
2. 尝试删除一个不存在的待办事项
3. 尝试删除一个已经被删除的待办事项
4. 尝试删除属于其他用户的待办事项

#### 9. 批量操作待办事项

- **URL**: `/api/todos/batch`
- **方法**: POST
- **描述**: 批量操作待办事项（完成、删除等）
- **认证**: 需要
- **请求体**:
  ```json
  {
    "todo_ids": ["string", "string"],
    "action": "complete" | "delete"
  }
  ```
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "success": true,
      "affected_items": integer
    }
    ```
- **错误响应**:
  - 状态码: 400
  - 响应体:
    ```json
    {
      "detail": "Invalid action"
    }
    ```

**测试用例**:
1. 批量完成多个待办事项
2. 批量删除多个待办事项
3. 尝试对不存在的待办事项进行批量操作
4. 使用无效的操作类型进行批量操作

#### 10. 获取待办事项统计

- **URL**: `/api/todos/stats`
- **方法**: GET
- **描述**: 获取当前用户的待办事项统计信息
- **认证**: 需要
- **成功响应**: 
  - 状态码: 200
  - 响应体:
    ```json
    {
      "total_todos": integer,
      "completed_todos": integer,
      "pending_todos": integer,
      "overdue_todos": integer
    }
    ```
- **错误响应**:
  - 状态码: 401
  - 响应体:
    ```json
    {
      "detail": "Not authenticated"
    }
    ```

**测试用例**:
1. 获取有待办事项的用户的统计信息
2. 获取没有待办事项的用户的统计信息
3. 创建新的待办事项后再次获取统计信息
4. 完成一些待办事项后再次获取统计信息

## 使用指南

### 用户认证

1. **注册账户**
   - 打开应用，点击“没有账号? 注册”按钮。
   - 输入用户名和密码，点击“注册”按钮。
   - 注册成功后，会提示“注册成功,请登录”。

2. **登录**
   - 输入已注册的用户名和密码，点击“登录”按钮。
   - 登录成功后，会导航到设备管理页面。

### 设备管理

1. **查看设备列表**
   - 登录后，进入设备管理页面，可查看所有已注册的设备。
   - 每个设备以卡片形式展示，显示设备名称、MAC地址和通信通道。

2. **添加新设备**
   - 点击右下角的“+”按钮，弹出添加设备对话框。
   - 输入设备名称、MAC地址和通信通道，点击“添加”。
   - 添加成功后，设备会出现在列表中。

3. **查看设备详情**
   - 点击设备卡片，进入设备详情页面。
   - 查看设备的ID、MAC地址和通信通道。
   - 点击“查看数据分析”按钮，进入数据分析页面。

### 数据分析

1. **查看数据**
   - 在设备详情页面，点击“查看数据分析”按钮。
   - 数据分析页面展示设备产生的数据，包括序号、值和时间。
   - 数据以表格形式展示，支持滚动查看。