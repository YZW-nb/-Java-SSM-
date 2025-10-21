<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>活动管理系统 - 社团管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                <a href="${pageContext.request.contextPath}/admin/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>


                <a href="${pageContext.request.contextPath}/club/manage" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>社团管理</span>
                </a>
                <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">活动管理中心</h2>
                <p class="text-gray-600">管理所有社团活动的创建、编辑与审批</p>
            </div>

            <!-- 功能导航栏 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-6">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <!-- 搜索表单 -->
                    <div class="w-full md:w-auto">
                        <form action="${pageContext.request.contextPath}/activitysignup/signup/list/all" method="get" class="flex">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="keyword" class="form-control me-2 pl-4 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary flex-grow" placeholder="搜索活动标题" required>
                            <button type="submit" class="btn btn-primary ml-2 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">
                                <i class="fa fa-search mr-1"></i> 搜索
                            </button>
                        </form>
                    </div>
                    <!-- 操作按钮 -->
                    <div class="flex items-center space-x-3 w-full md:w-auto justify-end">
                        <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all" class="btn btn-secondary px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors">
                            <i class="fa fa-home mr-1"></i> 返回主页
                        </a>
                        <button class="btn btn-success px-4 py-2 bg-secondary text-white rounded-lg hover:bg-secondary/90 transition-colors" data-bs-toggle="modal" data-bs-target="#addActivityModal">
                            <i class="fa fa-plus mr-1"></i> 新增活动
                        </button>
                        <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all?action=list" class="btn btn-info px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">
                            <i class="fa fa-list mr-1"></i> 活动列表
                        </a>
                    </div>
                </div>

            </div>

            <!-- 报名列表区域 -->
            <div class="bg-white rounded-xl p-6 card-shadow">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">活动报名列表</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">报名ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动标题</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">申请人ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">报名备注</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">审批状态</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动状态</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${signupList}" var="signup">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${signup.id}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${signup.activityTitle}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${signup.userId}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                       <div class="text-sm font-medium text-gray-900">${signup.remark}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${signup.approvalStatus}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">已通过</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">待审批</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${signup.activityStatus}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex space-x-2">
                                        <c:if test="${!signup.approvalStatus}">
                                            <!-- 通过按钮 -->
                                            <a href="${pageContext.request.contextPath}/activitysignup/signup/approve/${signup.id}?approved=true"
                                               class="btn btn-sm btn-success px-3 py-1 bg-green-100 text-green-800 rounded-lg hover:bg-green-200 transition-colors">
                                                <i class="fa fa-check mr-1"></i> 通过
                                            </a>

                                            <!-- 拒绝按钮 -->
                                            <a href="${pageContext.request.contextPath}/activitysignup/signup/approve/${signup.id}?approved=false"
                                               class="btn btn-sm btn-danger px-3 py-1 bg-red-100 text-red-800 rounded-lg hover:bg-red-200 transition-colors">
                                                <i class="fa fa-times mr-1"></i> 拒绝
                                            </a>
                                        </c:if>
                                        <c:if test="${signup.approvalStatus}">
                                            <!-- 已审批状态 -->
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                <i class="fa fa-check-circle mr-1"></i> 已审批
            </span>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty signupList}">
                            <tr>
                                <td colspan="7" class="px-6 py-4 text-center text-gray-500">暂无报名数据</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
<%--            --%>
            <!-- 活动列表区域 -->
            <div class="bg-white rounded-xl p-6 card-shadow mb-6">
                <div class="flex items-center justify-between mb-6">
                    <h3 class="text-xl font-bold text-gray-800">活动列表</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">活动标题</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">社团ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">开始时间</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">地点</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">状态</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">操作</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${activities}" var="activity">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${activity.id}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${activity.title}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${activity.clubId}</div>
                                </td>

                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${activity.location}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${activity.status == 1}">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">正常</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">已取消</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex space-x-2">
                                        <!-- 修改按钮 -->
                                        <button class="btn btn-sm btn-warning px-3 py-1 bg-yellow-100 text-yellow-800 rounded-lg hover:bg-yellow-200 transition-colors"
                                                data-bs-toggle="modal"
                                                data-bs-target="#editActivityModal"
                                                onclick="prepareEditForm(${activity.id}, '${activity.title}', ${activity.clubId}, '${activity.startTime}', '${activity.location}', ${activity.status})">
                                            <i class="fa fa-edit mr-1"></i> 编辑
                                        </button>
                                        <!-- 取消活动按钮 -->
                                        <c:if test="${activity.status == 1}">
                                            <a href="${pageContext.request.contextPath}/activitysignup/signup/list/all?action=delete&id=${activity.id}"
                                               class="btn btn-sm btn-danger px-3 py-1 bg-red-100 text-red-800 rounded-lg hover:bg-red-200 transition-colors"
                                               onclick="return confirm('确定要取消该活动吗？')">
                                                <i class="fa fa-times mr-1"></i> 取消
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty activities and not empty param.action and param.action eq 'list'}">
                            <tr>
                                <td colspan="7" class="px-6 py-4 text-center text-muted">暂无活动数据</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 新增活动模态框 -->
            <div class="modal fade" id="addActivityModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content rounded-xl shadow-lg">
                        <form action="${pageContext.request.contextPath}/activitysignup/signup/list/all" method="get">
                            <div class="modal-header bg-gray-50 px-6 py-4 rounded-t-xl">
                                <h5 class="modal-title text-lg font-bold text-gray-800">新增活动</h5>
                                <button type="button" class="btn-close text-gray-500 hover:text-gray-700" data-bs-dismiss="modal" aria-label="Close">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                            <div class="modal-body p-6">
                                <input type="hidden" name="action" value="add">
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">活动标题 <span class="text-red-500">*</span></label>
                                    <input type="text" name="title" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">社团ID(选择已有社团ID) <span class="text-red-500">*</span></label>
                                    <input type="number" name="clubId" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">开始时间 <span class="text-red-500">*</span></label>
                                    <input type="datetime-local" name="startTime" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">活动地点 <span class="text-red-500">*</span></label>
                                    <input type="text" name="location" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                            </div>
                            <div class="modal-footer bg-gray-50 px-6 py-4 rounded-b-xl flex justify-end">
                                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors mr-2" data-bs-dismiss="modal">取消</button>
                                <button type="submit" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">保存</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 编辑活动模态框 -->
            <div class="modal fade" id="editActivityModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content rounded-xl shadow-lg">
                        <form action="${pageContext.request.contextPath}/activitysignup/signup/list/all" method="get">
                            <div class="modal-header bg-gray-50 px-6 py-4 rounded-t-xl">
                                <h5 class="modal-title text-lg font-bold text-gray-800">编辑活动</h5>
                                <button type="button" class="btn-close text-gray-500 hover:text-gray-700" data-bs-dismiss="modal" aria-label="Close">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                            <div class="modal-body p-6">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" id="editId"> <!-- 关键：传递活动ID -->
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">活动标题 <span class="text-red-500">*</span></label>
                                    <input type="text" name="title" id="editTitle" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">社团ID(选择已有社团ID) <span class="text-red-500">*</span></label>
                                    <input type="number" name="clubId" id="editClubId" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">开始时间 <span class="text-red-500">*</span></label>
                                    <input type="datetime-local" name="startTime" id="editStartTime" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">活动地点 <span class="text-red-500">*</span></label>
                                    <input type="text" name="location" id="editLocation" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">活动状态 <span class="text-red-500">*</span></label>
                                    <select name="status" id="editStatus" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" required>
                                        <option value="1">正常</option>
                                        <option value="0">已取消</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer bg-gray-50 px-6 py-4 rounded-b-xl flex justify-end">
                                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors mr-2" data-bs-dismiss="modal">取消</button>
                                <button type="submit" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">更新</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
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

    // 准备编辑表单数据（修复时间格式问题）
    function prepareEditForm(id, title, clubId, startTime, location, status) {
        // 填充表单数据
        document.getElementById("editId").value = id;
        document.getElementById("editTitle").value = title;
        document.getElementById("editClubId").value = clubId;
        document.getElementById("editLocation").value = location;
        document.getElementById("editStatus").value = status;

        // 关键修复：处理时间格式转换
        if (startTime) {
            // 后端LocalDateTime可能返回"2023-10-01T14:30"或"2023-10-01 14:30"格式
            const formattedTime = startTime.replace(" ", "T").substring(0, 16);
            document.getElementById("editStartTime").value = formattedTime;
        }
    }

    // 页面加载时判断是否有活动列表数据
    document.addEventListener('DOMContentLoaded', function() {
        const activities = ${empty activities ? 'null' : 'true'};
        const action = '${param.action}';
        if (action === 'list' && !activities) {
            console.log('当前没有活动数据');
        }
    });

</script>
</body>
</html>