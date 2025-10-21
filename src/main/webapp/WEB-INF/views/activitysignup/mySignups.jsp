<!-- activitysignup/mySignups.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的报名 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/student/me" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-home w-5 text-center"></i>
                    <span>首页</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/member/my"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-university w-5 text-center"></i>
                    <span>我的社团</span>
                </a>
                <a href="${pageContext.request.contextPath}/activity/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动列表</span>
                </a>
                <a href="${pageContext.request.contextPath}/activity/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-calendar-check-o w-5 text-center"></i>
                    <span>我的活动</span>
                </a>
                <a href="${pageContext.request.contextPath}/fund/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-credit-card w-5 text-center"></i>
                    <span>经费申请</span>
                </a>
                <a href="${pageContext.request.contextPath}/club/apply/toApplyPage"    class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-file-text w-5 text-center"></i>
                    <span>社团申请</span>
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
                        <input type="text" placeholder="搜索我的活动..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">我的活动</h2>
                <p class="text-gray-600">查看和管理你报名参加的活动</p>
            </div>

            <!-- 筛选条件 -->
            <div class="bg-white rounded-xl p-4 card-shadow mb-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">活动状态</label>
                        <select class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="all">全部状态</option>
                            <option value="upcoming">即将开始</option>
                            <option value="ongoing">进行中</option>
                            <option value="completed">已结束</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">社团筛选</label>
                        <select class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="all">所有社团</option>
                            <option value="1">文化社团</option>
                            <option value="2">音乐社团</option>
                            <option value="3">体育社团</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">时间范围</label>
                        <select class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="all">全部时间</option>
                            <option value="week">本周</option>
                            <option value="month">本月</option>
                            <option value="semester">本学期</option>
                        </select>
                    </div>
                </div>
                <div class="mt-4 flex justify-end">
                    <button class="bg-primary hover:bg-primary/90 text-white px-6 py-2 rounded-lg text-sm transition-colors flex items-center">
                        <i class="fa fa-filter mr-2"></i> 应用筛选
                    </button>
                </div>
            </div>

            <!-- 我的报名列表 -->
            <div class="space-y-6">
                <c:if test="${empty signups}">
                <div class="bg-white rounded-xl p-8 card-shadow text-center">
                    <div class="text-gray-400 mb-4">
                        <i class="fa fa-calendar-o text-5xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-800 mb-2">你还没有报名任何活动</h3>
                    <p class="text-gray-600 mb-4">浏览并报名感兴趣的活动，丰富你的校园生活</p>
                    <a href="${pageContext.request.contextPath}/activity/list" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary hover:bg-primary/90 transition-colors">
                        <i class="fa fa-search mr-2"></i> 浏览活动
                    </a>
                </div>
                </c:if>

                <c:if test="${not empty signups}">
                <c:forEach var="signup" items="${signups}">
                <div class="bg-white rounded-xl overflow-hidden card-shadow hover:shadow-lg transition-shadow">
                    <div class="flex flex-col md:flex-row">
                        <div class="md:w-1/4 h-48 md:h-auto relative">
                            <c:choose>
                                <c:when test="${signup.activity.id == 1}">
                                    <img src="https://picsum.photos/id/1025/600/400" alt="校园文化节" class="w-full h-full object-cover">
                                </c:when>
                                <c:when test="${signup.activity.id == 2}">
                                    <img src="https://picsum.photos/id/1012/600/400" alt="校园歌手大赛" class="w-full h-full object-cover">
                                </c:when>
                                <c:when test="${signup.activity.id == 3}">
                                    <img src="https://picsum.photos/id/1062/600/400" alt="羽毛球淘汰赛" class="w-full h-full object-cover">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://picsum.photos/id/100/600/400" alt="默认活动图片" class="w-full h-full object-cover">
                                </c:otherwise>
                            </c:choose>

                            <c:set var="now" value="<%= LocalDateTime.now() %>" />
                            <c:choose>
                                <c:when test="${signup.activity.status == 1}">
                                    <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-green-600">
                                        进行中
                                    </div>
                                </c:when>
                                <c:when test="${signup.activity.startTime.isAfter(now)}">
                                    <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-blue-600">
                                        即将开始
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-gray-600">
                                        已结束
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="md:w-3/4 p-6">
                            <div class="flex flex-col md:flex-row md:items-center justify-between mb-3">
                                <div>
                                    <h3 class="text-xl font-bold text-gray-800">${signup.activity.title}</h3>
                                    <div class="flex items-center mt-2">
                                        <c:choose>
                                            <c:when test="${signup.activity.clubId == 1}">
                                                <img src="https://picsum.photos/id/1025/30/30" alt="文化社团" class="w-6 h-6 rounded-full mr-2">
                                                <span class="text-gray-600">文化社团</span>
                                            </c:when>
                                            <c:when test="${signup.activity.clubId == 2}">
                                                <img src="https://picsum.photos/id/1012/30/30" alt="音乐社团" class="w-6 h-6 rounded-full mr-2">
                                                <span class="text-gray-600">音乐社团</span>
                                            </c:when>
                                            <c:when test="${signup.activity.clubId == 3}">
                                                <img src="https://picsum.photos/id/1062/30/30" alt="体育社团" class="w-6 h-6 rounded-full mr-2">
                                                <span class="text-gray-600">体育社团</span>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://picsum.photos/id/100/30/30" alt="默认社团" class="w-6 h-6 rounded-full mr-2">
                                                <span class="text-gray-600">未知社团</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="mt-3 md:mt-0">
                                            <span class="text-sm text-gray-500">
                                                <i class="fa fa-clock-o mr-1"></i>
                                                <c:set var="formatter" value="<%= DateTimeFormatter.ofPattern(\"yyyy-MM-dd HH:mm\") %>" />
                                                ${formatter.format(signup.activity.startTime)}
                                            </span>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                                <div class="flex items-start">

                                    <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center mr-2 flex-shrink-0">
                                        <i class="fa fa-map-marker text-primary text-sm"></i>
                                    </div>
                                    <div>
                                        <h4 class="font-medium text-gray-800 text-sm">活动地点</h4>
                                        <p class="text-gray-600 text-sm">${signup.activity.location}</p>
                                    </div>
                                </div>
                                <div class="flex items-start">
                                    <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center mr-2 flex-shrink-0">
                                        <i class="fa fa-user-plus text-secondary text-sm"></i>
                                    </div>
                                    <div>
                                        <h4 class="font-medium text-gray-800 text-sm">报名时间</h4>
                                        <p class="text-gray-600 text-sm">${formatter.format(signup.signupTime)}</p>
                                    </div>
                                </div>
                                <div class="flex items-start">
                                    <div class="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center mr-2 flex-shrink-0">
                                        <i class="fa fa-info-circle text-accent text-sm"></i>
                                    </div>
                                    <div>
                                        <h4 class="font-medium text-gray-800 text-sm">报名状态</h4>
                                        <p class="text-green-600 text-sm">
                                            <i class="fa fa-check-circle mr-1"></i> 已确认
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-4 flex justify-between items-center">
                                <div>
                                    <a href="${pageContext.request.contextPath}/activity/detail/${signup.activity.id}"
                                       class="text-primary hover:text-primary/80 font-medium text-sm flex items-center">
                                        <i class="fa fa-arrow-right mr-1"></i> 查看详情
                                    </a>
                                </div>
                                <div class="flex space-x-2">
                                    <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-1 rounded-lg text-sm transition-colors flex items-center">
                                        <i class="fa fa-share-alt mr-1"></i> 分享
                                    </button>
                                    <a href="${pageContext.request.contextPath}/activity/signup/cancel/${signup.id}"
                                       class="bg-red-100 hover:bg-red-200 text-red-700 px-3 py-1 rounded-lg text-sm transition-colors flex items-center">
                                        <i class="fa fa-times mr-1"></i> 取消报名
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                </c:if>
            </div>

            <!-- 分页控件 -->
            <div class="mt-8 flex justify-center">
                <nav class="inline-flex rounded-md shadow-sm" aria-label="Pagination">
                    <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                        <span class="sr-only">上一页</span>
                        <i class="fa fa-chevron-left"></i>
                    </a>
                    <a href="#" aria-current="page" class="z-10 bg-primary text-white relative inline-flex items-center px-4 py-2 border border-primary text-sm font-medium">1</a>
                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">2</a>
                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">3</a>
                    <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                        ...
                    </span>
                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">8</a>
                    <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">9</a>
                    <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                        <span class="sr-only">下一页</span>
                        <i class="fa fa-chevron-right"></i>
                    </a>
                </nav>
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
</script>
</body>
</html>