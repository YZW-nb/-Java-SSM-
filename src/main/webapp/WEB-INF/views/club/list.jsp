<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>社团列表 - 社团管理系统</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome 图标 -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- Tailwind 自定义配置 -->
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

    <!-- 自定义工具类 -->
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto { content-visibility: auto; }
            .card-shadow { box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); }
            .nav-active { @apply bg-primary/10 text-primary border-l-4 border-primary; }
            .force-grid {
                display: grid !important;
                grid-template-columns: repeat(1, minmax(0, 1fr)) !important;
                gap: 2rem !important;
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
                <i class="fa fa-users text-primary text-2xl"></i>
                <h1 class="text-xl font-bold text-gray-800">社团管理系统</h1>
            </div>
            <button id="toggle-sidebar" class="lg:hidden text-gray-500 hover:text-primary">
                <i class="fa fa-bars"></i>
            </button>
        </div>

        <div class="p-4">
            <div class="flex items-center space-x-3 mb-6">
                <img src="https://picsum.photos/id/64/40/40" alt="用户头像" class="w-10 h-10 rounded-full object-cover border-2 border-primary">
                <div>
                    <p class="font-medium text-gray-800">张三</p>
                    <p class="text-xs text-gray-500">信息学院</p>
                </div>
            </div>

            <nav class="space-y-1">
                <a href="${pageContext.request.contextPath}/student/home" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/member/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>我的社团</span>
                </a>

                <a href="${pageContext.request.contextPath}/activity/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动列表</span>
                </a>
                <a href="${pageContext.request.contextPath}/fund/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/apply/toApplyPage" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-file-text w-5 text-center"></i>
                    <span>社团申请</span>
                </a>
            </nav>
        </div>

        <div class="absolute bottom-0 w-full p-4 border-t">
            <a href="#" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">社团列表</h2>
                <p class="text-gray-600">探索并加入感兴趣的社团</p>
            </div>

<%--            <!-- 调试信息：确认数据传递 -->--%>
<%--            <div class="mb-4 p-4 bg-yellow-50 border border-yellow-300 rounded">--%>
<%--                <p class="text-sm text-gray-600">后端传递的 clubs 数据：</p>--%>
<%--                <pre class="text-sm text-gray-800">${clubs}</pre>--%>
<%--                <p class="text-sm text-gray-600">数据数量：${not empty clubs ? clubs.size() : 0}</p>--%>
<%--                <c:if test="${not empty clubs}">--%>
<%--                    <ul class="text-sm text-gray-800 list-disc pl-4 mt-2">--%>
<%--                        <c:forEach items="${clubs}" var="club">--%>
<%--                            <li>ID: ${club.id} | 名称: ${club.name} | 封面: ${club.coverUrl}</li>--%>
<%--                        </c:forEach>--%>
<%--                    </ul>--%>
<%--                </c:if>--%>
<%--            </div>--%>

            <div class="bg-white rounded-xl p-6 card-shadow mb-8">
                <form action="${pageContext.request.contextPath}/club/search" method="GET" class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
                    <div class="flex items-center mb-4 md:mb-0">
                        <div class="relative mr-4 w-40">
                            <select name="category" class="w-full pl-4 pr-10 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary appearance-none bg-white">
                                <option value="">所有类别</option>
                                <option value="tech">学术科技</option>
                                <option value="art">文化艺术</option>
                                <option value="sports">体育健身</option>
                                <option value="volunteer">志愿服务</option>
                                <option value="hobby">兴趣爱好</option>
                            </select>
                            <i class="fa fa-chevron-down absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>
                        </div>
                        <div class="relative w-40">
                            <select name="sort" class="w-full pl-4 pr-10 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary appearance-none bg-white">
                                <option value="newest">最新创建</option>
                                <option value="members">最多成员</option>
                                <option value="active">最近活跃</option>
                            </select>
                            <i class="fa fa-chevron-down absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <div class="relative mr-4">
                            <input type="text" name="keyword" placeholder="搜索社团..." value="${param.keyword}" class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-full md:w-64">
                            <i class="fa fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        </div>
                        <button type="submit" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors">
                            <i class="fa fa-filter mr-1"></i> 筛选
                        </button>
                    </div>
                </form>

                <c:if test="${not empty searchMessage}">
                    <div class="bg-blue-50 border border-blue-200 text-blue-700 px-4 py-3 rounded-lg mb-4">
                        <div class="flex items-center">
                            <i class="fa fa-info-circle mr-2"></i>
                            <span>${searchMessage}</span>
                        </div>
                    </div>
                </c:if>

                <!-- 社团卡片容器 -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:if test="${empty clubs}">
                        <div class="col-span-full py-12 text-center">
                            <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gray-100 mb-4">
                                <i class="fa fa-search text-gray-400 text-2xl"></i>
                            </div>
                            <h3 class="text-xl font-medium text-gray-900 mb-2">没有找到匹配的社团</h3>
                            <p class="text-gray-500">请尝试使用不同的关键词或筛选条件</p>
                        </div>
                    </c:if>

                    <c:if test="${not empty clubs}">
                        <c:forEach items="${clubs}" var="club">
                            <div class="border border-gray-200 rounded-xl overflow-hidden hover:shadow-md transition-shadow">
                                <!-- 封面图区域 -->
                                <div class="h-40 bg-primary/10 relative">
                                    <!-- 兼容 coverUrl 为 null 的情况 -->
                                    <c:set var="defaultCover" value="https://picsum.photos/id/${club.id != null ? club.id : 1}/600/400" />
                                    <img
                                            src="${club.coverUrl != null ? club.coverUrl : defaultCover}"
                                            alt="${club.name}封面"
                                            class="w-full h-full object-cover"
                                    >
                                    <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-primary">
                                        可加入
                                    </div>
                                </div>

                                <!-- 社团信息区域 -->
                                <div class="p-4">
                                    <h4 class="font-bold text-gray-800 text-lg">${club.name}</h4>
                                    <p class="text-gray-600 text-sm mt-1">
                                        <!-- 兼容简介为空 -->
                                            ${club.intro != null ? club.intro : '暂无详细介绍'}
                                    </p>
                                    <div class="flex items-center mt-3 text-gray-500 text-sm">
                                        <!-- 成员数（示例：假设实体类无此字段，可删除或替换为真实逻辑） -->
                                        <span class="flex items-center mr-4">
                                            <i class="fa fa-users mr-1"></i>
                                            ${club.id * 10} 成员
                                        </span>
                                        <!-- 成立时间 -->
                                        <span class="flex items-center">
                                            <i class="fa fa-calendar mr-1"></i>
                                            ${club.createTime}
                                        </span>
                                    </div>
                                    <div class="flex items-center justify-between mt-4">
                                        <a
                                                href="${pageContext.request.contextPath}/club/detail/${club.id}"
                                                class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors"
                                        >
                                            详情
                                        </a>
                                        <a
                                                href="${pageContext.request.contextPath}/club/member/join/${club.id}"
                                                class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors"
                                        >
                                            加入
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>

                <!-- 分页控件 -->
                <div class="mt-8 flex justify-center">
                    <nav class="inline-flex rounded-md shadow">
                        <c:if test="${page > 1}">
                            <a
                                    href="${pageContext.request.contextPath}/club/list?page=${page-1}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}"
                                    class="px-3 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 rounded-l-md"
                            >
                                <span class="sr-only">上一页</span>
                                <i class="fa fa-chevron-left"></i>
                            </a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <a
                                    href="${pageContext.request.contextPath}/club/list?page=${p}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}"
                                    class="px-3 py-2 border border-gray-300 ${p == page ? 'bg-primary text-white' : 'bg-white text-gray-700'} text-sm font-medium hover:bg-gray-50"
                            >
                                    ${p}
                            </a>
                        </c:forEach>

                        <c:if test="${page < totalPages}">
                            <a
                                    href="${pageContext.request.contextPath}/club/list?page=${page+1}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}"
                                    class="px-3 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-r-md"
                            >
                                <span class="sr-only">下一页</span>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </nav>
                </div>
            </div>
        </main>

    </div>
</div>

<!-- 移动端侧边栏控制脚本 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const toggleSidebar = document.getElementById('toggle-sidebar');
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const sidebar = document.getElementById('sidebar');

        // 侧边栏切换逻辑
        function toggleSidebarVisibility() {
            if (sidebar.classList.contains('-translate-x-full')) {
                sidebar.classList.remove('-translate-x-full');
            } else {
                sidebar.classList.add('-translate-x-full');
            }
        }

        // 初始化移动端侧边栏状态
        function initSidebar() {
            if (window.innerWidth < 1024) {
                sidebar.classList.add('-translate-x-full');
            } else {
                sidebar.classList.remove('-translate-x-full');
            }
        }

        // 监听窗口大小变化，调整侧边栏状态
        window.addEventListener('resize', initSidebar);

        // 绑定侧边栏切换事件
        if (toggleSidebar) toggleSidebar.addEventListener('click', toggleSidebarVisibility);
        if (mobileMenuButton) mobileMenuButton.addEventListener('click', toggleSidebarVisibility);

        // 初始化
        initSidebar();
    });
</script>
</body>
</html>