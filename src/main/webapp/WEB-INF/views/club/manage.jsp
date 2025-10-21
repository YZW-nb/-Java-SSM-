<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>社团管理 - 社团管理系统</title>
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
            .content-auto {
                content-visibility: auto;
            }
            .card-shadow {
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }
            .nav-active {
                @apply bg-primary/10 text-primary border-l-4 border-primary;
            }
        }
    </style>
</head>
<body class="bg-base-100 font-sans">
<div class="flex h-screen overflow-hidden">
    <!-- 侧边栏 -->
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
                <a href="${pageContext.request.contextPath}/admin/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/manage" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>社团管理</span>
                </a>
                <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动审批</span>
                </a>
                <a href="${pageContext.request.contextPath}/fund/management" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费管理</span>
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
        <!-- 顶部导航栏 -->
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

                    <div class="relative">
                        <button class="p-2 rounded-full hover:bg-gray-100 relative">
                            <i class="fa fa-envelope-o text-gray-600"></i>
                            <span class="absolute top-0 right-0 w-2 h-2 bg-blue-500 rounded-full"></span>
                        </button>
                    </div>
                </div>
            </div>
        </header>

        <!-- 内容滚动区域 -->
        <main class="flex-1 overflow-y-auto p-6 bg-gray-50">
            <div class="mb-6">
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">社团管理</h2>
                <p class="text-gray-600">在这里管理所有社团信息</p>
            </div>

            <!-- 社团列表 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">我的社团</h3>
                    <a href="#" class="text-primary hover:text-primary/80 flex items-center text-sm">
                        查看全部 <i class="fa fa-angle-right ml-1"></i>
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团名称</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">类别</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">创始人</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${clubs}" var="club">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${club.name}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${club.category}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${club.founderId}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${club.status == 1}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                正常
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                                解散
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <a href="/club/edit/${club.id}" class="text-primary hover:text-primary/80 mr-3">编辑</a>
                                    <a href="/club/delete/${club.id}" onclick="return confirm('确定要删除这个社团吗？')" class="text-red-500 hover:text-red-800">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>



            <!-- 社团申请列表 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">社团申请审核</h3>
                    <div class="flex items-center space-x-3">
                        <div class="relative">
                            <select id="statusFilter" class="pl-3 pr-10 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary text-sm appearance-none bg-white">
                                <option value="all">全部状态</option>
                                <option value="pending">待审核</option>
                                <option value="approved">已通过</option>
                                <option value="rejected">已拒绝</option>
                            </select>
                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                <i class="fa fa-chevron-down text-xs"></i>
                            </div>
                        </div>
                        <button id="filterBtn" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">
                            <i class="fa fa-filter mr-1"></i> 筛选
                        </button>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">用户ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请理由</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请时间</th>
                            <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200" id="applyTableBody">
                        <c:forEach items="${applies}" var="apply">
                            <tr data-status="${apply.status}">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${apply.id}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${apply.clubId}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${apply.userId}</div>
                                </td>
                                <td class="px-6 py-4 max-w-xs">
                                    <div class="text-sm text-gray-900 line-clamp-2">${apply.reason}</div>
                                    <button class="text-xs text-primary hover:text-primary/80 mt-1 view-reason" data-reason="${apply.reason}">查看全文</button>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${apply.status == 'pending'}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">待审核</span>
                                        </c:when>
                                        <c:when test="${apply.status == 'approved'}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">已通过</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">已拒绝</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">
                                        <fmt:formatDate value="${apply.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <c:if test="${apply.status == 'pending'}">
                                        <a href="/club/apply/approve/${apply.id}" class="px-3 py-1 bg-green-100 text-green-800 rounded hover:bg-green-200 transition-colors mr-2">
                                            <i class="fa fa-check mr-1"></i> 通过
                                        </a>
                                        <a href="/club/apply/reject/${apply.id}" class="px-3 py-1 bg-red-100 text-red-800 rounded hover:bg-red-200 transition-colors">
                                            <i class="fa fa-times mr-1"></i> 拒绝
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- 空状态 -->
                        <c:if test="${empty applies}">
                            <tr>
                                <td colspan="7" class="px-6 py-10 text-center text-gray-500">
                                    <div class="flex flex-col items-center">
                                        <i class="fa fa-inbox text-4xl mb-3 text-gray-300"></i>
                                        <p>暂无社团申请记录</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <div class="flex items-center justify-between mt-6">
                    <div class="text-sm text-gray-700">
                        显示 1 到 ${applies.size() > 10 ? 10 : applies.size()} 条，共 ${applies.size()} 条
                    </div>
                    <div class="flex space-x-1">
                        <a href="#" class="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm">上一页</a>
                        <a href="#" class="px-3 py-1 border border-gray-300 rounded bg-primary text-white text-sm">1</a>
                        <a href="#" class="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm">2</a>
                        <a href="#" class="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm">3</a>
                        <span class="px-3 py-1 text-sm">...</span>
                        <a href="#" class="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm">10</a>
                        <a href="#" class="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm">下一页</a>
                    </div>
                </div>
            </div>

            <!-- 新增社团表单 -->
            <div class="bg-white rounded-xl p-6 card-shadow">
                <h3 class="text-xl font-bold text-gray-800 mb-6">新增社团</h3>
                <form action="/club/add" method="post">
                    <div class="mb-4">
                        <label for="club-name" class="block text-sm font-medium text-gray-700">社团名称</label>
                        <input type="text" id="club-name" name="name" required
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm">
                    </div>
                    <div class="mb-4">
                        <label for="club-category" class="block text-sm font-medium text-gray-700">类别</label>
                        <input type="text" id="club-category" name="category" required
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm">
                    </div>
                    <div class="mb-4">
                        <label for="club-intro" class="block text-sm font-medium text-gray-700">社团简介</label>
                        <textarea id="club-intro" name="intro" rows="3" required
                                  class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary focus:border-primary sm:text-sm"></textarea>
                    </div>
                    <div class="flex justify-end">
                        <button type="submit" class="px-4 py-2 bg-primary text-white rounded-md hover:bg-primary/80 focus:outline-none focus:ring-2 focus:ring-primary/50">新增</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

<!-- 查看全文模态框 -->
<div id="reasonModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-semibold text-gray-900">申请理由详情</h3>
            <button id="closeModal" class="text-gray-500 hover:text-gray-700">
                <i class="fa fa-times"></i>
            </button>
        </div>
        <div id="reasonContent" class="text-gray-700 mb-6"></div>
        <div class="flex justify-end">
            <button id="confirmModal" class="px-4 py-2 bg-primary text-white rounded-md hover:bg-primary/80">
                确定
            </button>
        </div>
    </div>
</div>

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

    // 查看全文模态框
    const reasonModal = document.getElementById('reasonModal');
    const reasonContent = document.getElementById('reasonContent');
    const closeModal = document.getElementById('closeModal');
    const confirmModal = document.getElementById('confirmModal');

    // 查看全文按钮点击事件
    document.querySelectorAll('.view-reason').forEach(button => {
        button.addEventListener('click', function() {
            const reason = this.getAttribute('data-reason');
            reasonContent.textContent = reason;
            reasonModal.classList.remove('hidden');
        });
    });

    // 关闭模态框
    closeModal.addEventListener('click', function() {
        reasonModal.classList.add('hidden');
    });

    confirmModal.addEventListener('click', function() {
        reasonModal.classList.add('hidden');
    });

    // 点击模态框外部关闭
    reasonModal.addEventListener('click', function(e) {
        if (e.target === reasonModal) {
            reasonModal.classList.add('hidden');
        }
    });

</script>
</body>
</html>