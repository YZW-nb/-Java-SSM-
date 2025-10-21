<!-- 活动表单页 - admin-activity-form.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${editMode ? '编辑活动' : '添加活动'} - 社团管理系统</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            primary: '#3B82F6',
            secondary: '#10B981',
            accent: '#8B5CF6',
            neutral: '#64748B',
            'base-100': '#F8FAFC',
          },
          fontFamily: {
            sans: ['Inter', 'system-ui', 'sans-serif'],
          },
        }
      }
    }
  </script>
  <style type="text/tailwindcss">
    @layer utilities {
      .content-auto { content-visibility: auto; }
      .card-shadow { box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); }
      .message-success { @apply bg-green-100 text-green-700; }
      .message-error { @apply bg-red-100 text-red-700; }
    }
  </style>
</head>
<body class="bg-base-100 font-sans">
<div class="flex h-screen overflow-hidden">
  <!-- 侧边栏（所有页面共用） -->
  <aside id="sidebar" class="w-64 bg-white shadow-lg transition-all duration-300 ease-in-out transform-gpu z-20">
    <div class="flex items-center justify-between p-4 border-b">
      <div class="flex items-center space-x-2">
        <i class="fa fa-shield text-primary text-2xl"></i>
        <h1 class="text-xl font-bold text-gray-800">社团管理系统</h1>
      </div>
      <button id="toggle-sidebar" class="lg:hidden text-gray-500 hover:text-primary">
        <i class="fa fa-bars"></i>
      </button>
    </div>

    <div class="p-4">
      <div class="flex items-center space-x-3 mb-6">
        <img src="https://picsum.photos/id/177/40/40" alt="管理员头像" class="w-10 h-10 rounded-full object-cover border-2 border-primary">
        <div>
          <p class="font-medium text-gray-800">李四</p>
          <p class="text-xs text-gray-500">学生处管理员</p>
        </div>
      </div>

      <nav class="space-y-1">
        <a href="${pageContext.request.contextPath}/admin/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
          <i class="fa fa-home w-5 text-center"></i>
          <span>首页</span>
        </a>
        <a href="${pageContext.request.contextPath}/club/manage" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
          <i class="fa fa-university w-5 text-center"></i>
          <span>社团管理</span>
        </a>
        <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
          <i class="fa fa-calendar w-5 text-center"></i>
          <span>活动审批</span>
        </a>
        <a href="${pageContext.request.contextPath}/activitysignup/activity/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
          <i class="fa fa-list w-5 text-center"></i>
          <span>活动管理</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users/user/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
          <i class="fa fa-users w-5 text-center"></i>
          <span>用户管理</span>
        </a>
      </nav>
    </div>

    <div class="absolute bottom-0 w-full p-4 border-t">
      <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
        <i class="fa fa-sign-out w-5 text-center text-red-500"></i>
        <span class="text-red-500">退出登录</span>
      </a>
    </div>
  </aside>

  <!-- 主内容区 -->
  <div class="flex-1 flex flex-col overflow-hidden">
    <!-- 顶部导航栏（所有页面共用） -->
    <header class="bg-white shadow-sm z-10">
      <div class="flex items-center justify-between p-4">
        <div class="flex items-center lg:hidden">
          <button id="mobile-menu-button" class="text-gray-500 hover:text-primary">
            <i class="fa fa-bars text-xl"></i>
          </button>
        </div>

        <div class="flex items-center space-x-4">
          <div class="relative">
            <input type="text" placeholder="搜索..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
            <i class="fa fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
          </div>

          <div class="relative">
            <button class="p-2 rounded-full hover:bg-gray-100 relative">
              <i class="fa fa-bell-o text-gray-600"></i>
              <span class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
            </button>
          </div>
        </div>
      </div>
    </header>

    <!-- 内容滚动区域 -->
    <main class="flex-1 overflow-y-auto p-6 bg-gray-50">
      <div class="mb-6">
        <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">${editMode ? '编辑活动' : '添加活动'}</h2>
        <p class="text-gray-600">${editMode ? '修改活动信息' : '创建新的社团活动'}</p>
      </div>

      <!-- 消息提示（显示操作结果） -->
      <c:if test="${not empty message}">
        <div class="p-4 rounded-lg mb-6 ${messageType == 'success' ? 'message-success' : 'message-error'}">
          <p>${message}</p>
        </div>
      </c:if>

      <!-- 活动表单 -->
      <div class="bg-white rounded-xl p-6 card-shadow mb-8">
        <form id="activity-form" method="post"
              action="${editMode ? pageContext.request.contextPath + '/activitysignup/activity/edit/' + activity.id : pageContext.request.contextPath + '/activitysignup/activity/add'}">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="md:col-span-2">
              <label for="title" class="block text-sm font-medium text-gray-700 mb-1">活动标题 <span class="text-red-500">*</span></label>
              <input type="text" id="title" name="title" value="${activity.title}" required
                     class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
            </div>

            <div>
              <label for="clubId" class="block text-sm font-medium text-gray-700 mb-1">所属社团 <span class="text-red-500">*</span></label>
              <select id="clubId" name="clubId" required
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
                <option value="">请选择社团</option>
                <option value="1" ${activity.clubId == 1 ? 'selected' : ''}>计算机协会</option>
                <option value="2" ${activity.clubId == 2 ? 'selected' : ''}>音乐社</option>
                <option value="3" ${activity.clubId == 3 ? 'selected' : ''}>志愿者联盟</option>
                <option value="4" ${activity.clubId == 4 ? 'selected' : ''}>篮球俱乐部</option>
              </select>
            </div>

            <div>
              <label for="type" class="block text-sm font-medium text-gray-700 mb-1">活动类型 <span class="text-red-500">*</span></label>
              <select id="type" name="type" required
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
                <option value="">请选择类型</option>
                <option value="1" ${activity.type == 1 ? 'selected' : ''}>学术科技</option>
                <option value="2" ${activity.type == 2 ? 'selected' : ''}>文化艺术</option>
                <option value="3" ${activity.type == 3 ? 'selected' : ''}>志愿服务</option>
                <option value="4" ${activity.type == 4 ? 'selected' : ''}>体育竞技</option>
              </select>
            </div>

            <div>
              <label for="startTime" class="block text-sm font-medium text-gray-700 mb-1">开始时间 <span class="text-red-500">*</span></label>
              <input type="datetime-local" id="startTime" name="startTime" value="${activity.startTime}" required
                     class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
            </div>

            <div>
              <label for="location" class="block text-sm font-medium text-gray-700 mb-1">活动地点 <span class="text-red-500">*</span></label>
              <input type="text" id="location" name="location" value="${activity.location}" required
                     class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
            </div>

            <div class="md:col-span-2">
              <label for="description" class="block text-sm font-medium text-gray-700 mb-1">活动描述 <span class="text-red-500">*</span></label>
              <textarea id="description" name="description" rows="4" required
                        class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">${activity.description}</textarea>
            </div>

            <div>
              <label for="status" class="block text-sm font-medium text-gray-700 mb-1">活动状态 <span class="text-red-500">*</span></label>
              <select id="status" name="status" required
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
                <option value="0" ${activity.status == 0 ? 'selected' : ''}>草稿</option>
                <option value="1" ${activity.status == 1 ? 'selected' : ''}>已发布</option>
                <option value="2" ${activity.status == 2 ? 'selected' : ''}>已取消</option>
              </select>
            </div>
          </div>

          <div class="mt-8 flex justify-end space-x-3">
            <a href="${pageContext.request.contextPath}/activitysignup/activity/list" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
              返回列表
            </a>
            <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary hover:bg-primary/90">
              <i class="fa fa-save mr-2"></i>${editMode ? '保存修改' : '创建活动'}
            </button>
          </div>
        </form>
      </div>
    </main>
  </div>
</div>

<!-- JavaScript -->
<script>
  // 侧边栏切换
  document.getElementById('toggle-sidebar').addEventListener('click', function() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('-translate-x-full');
  });

  // 移动端菜单切换
  document.getElementById('mobile-menu-button').addEventListener('click', function() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('-translate-x-full');
  });

  // 窗口大小变化时处理侧边栏显示
  window.addEventListener('resize', function() {
    const sidebar = document.getElementById('sidebar');
    if (window.innerWidth >= 1024) {
      sidebar.classList.remove('-translate-x-full');
    }
  });

  // 表单提交前验证
  document.getElementById('activity-form').addEventListener('submit', function(e) {
    // 这里可以添加额外的表单验证逻辑
    const startTime = document.getElementById('startTime').value;
    if (!startTime) {
      alert('请选择活动开始时间');
      e.preventDefault();
      return false;
    }
  });

  // 自动关闭消息提示
  setTimeout(function() {
    const messageDiv = document.querySelector('.message-success, .message-error');
    if (messageDiv) {
      messageDiv.style.opacity = '0';
      setTimeout(function() {
        messageDiv.style.display = 'none';
      }, 500);
    }
  }, 5000);
</script>
</body>
</html>