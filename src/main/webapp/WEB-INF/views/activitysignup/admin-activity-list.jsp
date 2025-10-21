<!-- 活动管理列表页 - admin-activity-list.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>活动管理 - 社团管理系统</title>
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
            .status-badge { @apply inline-block px-2 py-1 rounded-full text-xs font-medium; }
            .status-draft { @apply bg-gray-100 text-gray-800; }
            .status-published { @apply bg-green-100 text-green-800; }
            .status-cancelled { @apply bg-red-100 text-red-800; }
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
                <a href="${pageContext.request.contextPath}/activitysignup/activity/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-primary/10 text-primary font-medium">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">活动管理</h2>
                <p class="text-gray-600">查看和管理所有社团活动</p>
            </div>

            <!-- 消息提示（显示操作结果） -->
            <c:if test="${not empty message}">
                <div class="p-4 rounded-lg mb-6 ${messageType == 'success' ? 'message-success' : 'message-error'}">
                    <p>${message}</p>
                </div>
            </c:if>

            <!-- 筛选区域 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                    <div>
                        <label for="activity-filter" class="block text-sm font-medium text-gray-700 mb-1">活动类型</label>
                        <select id="activity-filter" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
                            <option value="">全部活动</option>
                            <option value="1">学术科技</option>
                            <option value="2">文化艺术</option>
                            <option value="3">志愿服务</option>
                            <option value="4">体育竞技</option>
                        </select>
                    </div>
                    <div>
                        <label for="status-filter" class="block text-sm font-medium text-gray-700 mb-1">活动状态</label>
                        <select id="status-filter" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
                            <option value="">全部状态</option>
                            <option value="draft">草稿</option>
                            <option value="published">已发布</option>
                            <option value="cancelled">已取消</option>
                        </select>
                    </div>
                    <div>
                        <label for="club-filter" class="block text-sm font-medium text-gray-700 mb-1">所属社团</label>
                        <select id="club-filter" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary/20 focus:ring-opacity-50">
                            <option value="">全部社团</option>
                            <option value="1">计算机协会</option>
                            <option value="2">音乐社</option>
                            <option value="3">志愿者联盟</option>
                            <option value="4">篮球俱乐部</option>
                        </select>
                    </div>
                    <div>
                        <label for="search-input" class="block text-sm font-medium text-gray-700 mb-1">搜索</label>
                        <div class="relative">
                            <input type="text" id="search-input" placeholder="搜索活动..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-full">
                            <i class="fa fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        </div>
                    </div>
                </div>
                <div class="flex justify-end space-x-3">
                    <button id="reset-filter" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fa fa-refresh mr-2"></i>重置
                    </button>
                    <button id="apply-filter" class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-primary hover:bg-primary/90">
                        <i class="fa fa-filter mr-2"></i>应用筛选
                    </button>
                </div>
            </div>

            <!-- 活动列表（服务器端渲染数据） -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">活动列表</h3>
                    <a href="${pageContext.request.contextPath}/activitysignup/activity/add" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg shadow-sm text-white bg-primary hover:bg-primary/90">
                        <i class="fa fa-plus mr-2"></i>添加活动
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动标题</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团名称</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动时间</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动地点</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动状态</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <!-- 无数据时显示 -->
                        <c:if test="${empty activities}">
                            <tr>
                                <td colspan="7" class="px-6 py-10 text-center text-gray-500">
                                    <i class="fa fa-inbox mr-2"></i>暂无活动数据
                                </td>
                            </tr>
                        </c:if>
                        <!-- 遍历数据渲染 -->
                        <c:forEach items="${activities}" var="activity">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${activity.id}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${activity.title}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${activity.clubName}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-500">${activity.startTime}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-500">${activity.location}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="status-badge
                                        <c:if test="${activity.status == 0}">status-draft</c:if>
                                        <c:if test="${activity.status == 1}">status-published</c:if>
                                        <c:if test="${activity.status == 2}">status-cancelled</c:if>">
                                        <c:if test="${activity.status == 0}">草稿</c:if>
                                        <c:if test="${activity.status == 1}">已发布</c:if>
                                        <c:if test="${activity.status == 2}">已取消</c:if>
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <div class="flex justify-end space-x-2">
                                        <a href="${pageContext.request.contextPath}/activitysignup/activity/edit/${activity.id}" class="px-3 py-1 bg-primary text-white rounded-md hover:bg-primary/90 transition-colors">
                                            <i class="fa fa-pencil mr-1"></i>编辑
                                        </a>
                                        <button type="button" class="px-3 py-1 bg-red-500 text-white rounded-md hover:bg-red-600 transition-colors"
                                                onclick="deleteActivity('${activity.id}', '${activity.title}')">
                                            <i class="fa fa-trash mr-1"></i>删除
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <div class="flex items-center justify-between px-4 py-3 sm:px-6 mt-6">
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">
                                显示第 <span class="font-medium">1</span> 到 <span class="font-medium">10</span> 条，共 <span class="font-medium">24</span> 条记录
                            </p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">上一页</span>
                                    <i class="fa fa-chevron-left"></i>
                                </a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-primary text-sm font-medium text-white">
                                    1
                                </a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                    2
                                </a>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                    3
                                </a>
                                <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                                    ...
                                </span>
                                <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                    5
                                </a>
                                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">下一页</span>
                                    <i class="fa fa-chevron-right"></i>
                                </a>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- 删除确认模态框 -->
<div id="delete-modal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="bg-white rounded-lg p-6 w-full max-w-md mx-4 transform transition-all">
        <h3 class="text-lg font-medium text-gray-900 mb-4">确认删除</h3>
        <p class="text-gray-700 mb-6" id="delete-message">你确定要删除活动"活动标题"吗？</p>
        <div class="flex justify-end space-x-3">
            <button type="button" class="px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" onclick="closeDeleteModal()">
                取消
            </button>
            <a href="#" id="confirm-delete" class="px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-red-500 hover:bg-red-600">
                确认删除
            </a>
        </div>
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

    // 筛选按钮事件
    document.getElementById('reset-filter').addEventListener('click', function() {
        document.getElementById('activity-filter').value = '';
        document.getElementById('status-filter').value = '';
        document.getElementById('club-filter').value = '';
        document.getElementById('search-input').value = '';
    });

    document.getElementById('apply-filter').addEventListener('click', function() {
        // 实际项目中应收集筛选条件并重新加载数据
        alert('筛选功能已触发，实际项目中会根据条件加载数据');
    });

    // 显示删除确认模态框
    function deleteActivity(id, title) {
        document.getElementById('delete-message').textContent = `你确定要删除活动"${title}"吗？`;
        document.getElementById('confirm-delete').href = `${pageContext.request.contextPath}/activitysignup/activity/delete/${id}`;
        document.getElementById('delete-modal').classList.remove('hidden');
    }

    // 关闭删除确认模态框
    function closeDeleteModal() {
        document.getElementById('delete-modal').classList.add('hidden');
    }

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