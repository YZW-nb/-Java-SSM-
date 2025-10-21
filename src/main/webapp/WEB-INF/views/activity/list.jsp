<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>活动列表 - 社团管理系统</title>
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
                <a href="${pageContext.request.contextPath}/activity/list" class="flex items-center space-x-3 px-4 py-3 rounded-lg nav-active">
                    <i class="fa fa-calendar w-5 text-center"></i>
                    <span>活动列表</span>
                </a>
                <a href="${pageContext.request.contextPath}/activity/my" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
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
                <a href="${pageContext.request.contextPath}/user/setting" class="flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-100 transition-colors">
                    <i class="fa fa-cog w-5 text-center"></i>
                    <span>个人设置</span>
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
                        <input type="text" placeholder="搜索活动..." class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary w-64">
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
                <h2 class="text-[clamp(1.5rem,3vw,2rem)] font-bold text-gray-800">活动列表</h2>
                <p class="text-gray-600">浏览并参加感兴趣的校园活动</p>
            </div>

            <!-- 筛选条件 -->
            <div class="bg-white rounded-xl p-4 card-shadow mb-6">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">活动类型</label>
                        <select class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="all">全部类型</option>
                            <option value="academic">学术科技</option>
                            <option value="art">文艺娱乐</option>
                            <option value="sports">体育竞技</option>
                            <option value="volunteer">志愿服务</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">时间范围</label>
                        <select class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="all">全部时间</option>
                            <option value="today">今天</option>
                            <option value="week">本周</option>
                            <option value="month">本月</option>
                            <option value="future">未来</option>
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
                        <label class="block text-sm font-medium text-gray-700 mb-1">状态</label>
                        <select class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                            <option value="all">全部状态</option>
                            <option value="1">进行中</option>
                            <option value="0">已结束</option>
                        </select>
                    </div>
                </div>
                <div class="mt-4 flex justify-end">
                    <button class="bg-primary hover:bg-primary/90 text-white px-6 py-2 rounded-lg text-sm transition-colors flex items-center">
                        <i class="fa fa-filter mr-2"></i> 应用筛选
                    </button>
                </div>
            </div>

            <!-- 活动列表：仅使用后端返回的字段 -->
            <div class="space-y-6">
                <c:if test="${not empty activities}">
                    <c:forEach var="activity" items="${activities}">
                        <div class="bg-white rounded-xl overflow-hidden card-shadow hover:shadow-lg transition-shadow">
                            <div class="flex flex-col md:flex-row">
                                <div class="md:w-1/4 h-48 md:h-auto relative">
                                    <!-- 图片根据活动ID动态选择 -->
                                    <c:choose>
                                        <c:when test="${activity.id == 1}">
                                            <img src="https://picsum.photos/id/1025/600/400" alt="校园文化节" class="w-full h-full object-cover">
                                        </c:when>
                                        <c:when test="${activity.id == 2}">
                                            <img src="https://picsum.photos/id/1012/600/400" alt="校园歌手大赛" class="w-full h-full object-cover">
                                        </c:when>
                                        <c:when test="${activity.id == 3}">
                                            <img src="https://picsum.photos/id/1062/600/400" alt="羽毛球淘汰赛" class="w-full h-full object-cover">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://picsum.photos/id/100/600/400" alt="默认活动图片" class="w-full h-full object-cover">
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- 活动状态（仅用status字段） -->
                                    <c:choose>
                                        <c:when test="${activity.status == 1}">
                                            <div class="absolute top-3 right-3 bg-white rounded-full px-3 py-1 text-xs font-medium text-green-600">
                                                进行中
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
                                            <!-- 活动标题 -->
                                            <h3 class="text-xl font-bold text-gray-800">${activity.title}</h3>
                                            <div class="flex items-center mt-2">
                                                <!-- 社团信息（根据clubId显示） -->
                                                <c:choose>
                                                    <c:when test="${activity.clubId == 1}">
                                                        <img src="https://picsum.photos/id/1025/30/30" alt="文化社团" class="w-6 h-6 rounded-full mr-2">
                                                        <span class="text-gray-600">文化社团</span>
                                                    </c:when>
                                                    <c:when test="${activity.clubId == 2}">
                                                        <img src="https://picsum.photos/id/1012/30/30" alt="音乐社团" class="w-6 h-6 rounded-full mr-2">
                                                        <span class="text-gray-600">音乐社团</span>
                                                    </c:when>
                                                    <c:when test="${activity.clubId == 3}">
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
                                    </div>

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                                        <div class="flex items-start">
                                            <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center mr-2 flex-shrink-0">
                                                <i class="fa fa-calendar text-primary text-sm"></i>
                                            </div>
                                            <div>
                                                <h4 class="font-medium text-gray-800 text-sm">活动时间</h4>
                                                <!-- 仅显示startTime（后端返回了该字段） -->
                                                <c:set var="formatter" value="<%= DateTimeFormatter.ofPattern(\"yyyy-MM-dd HH:mm\") %>" scope="request" />
                                                <p class="text-gray-600 text-sm">
                                                        ${activity.startTime != null ? formatter.format(activity.startTime) : "未指定"}
                                                </p>
                                            </div>
                                        </div>
                                        <div class="flex items-start">
                                            <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center mr-2 flex-shrink-0">
                                                <i class="fa fa-map-marker text-secondary text-sm"></i>
                                            </div>
                                            <div>
                                                <h4 class="font-medium text-gray-800 text-sm">活动地点</h4>
                                                <p class="text-gray-600 text-sm">${activity.location != null ? activity.location : "未指定"}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex flex-wrap gap-2 mb-4">
                                        <!-- 活动类型标签（根据clubId推断） -->
                                        <c:choose>
                                            <c:when test="${activity.clubId == 1}">
                                                <span class="px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-xs">文化</span>
                                            </c:when>
                                            <c:when test="${activity.clubId == 2}">
                                                <span class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-xs">音乐</span>
                                            </c:when>
                                            <c:when test="${activity.clubId == 3}">
                                                <span class="px-3 py-1 bg-yellow-100 text-yellow-800 rounded-full text-xs">体育</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 bg-gray-100 text-gray-800 rounded-full text-xs">活动</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="flex flex-wrap gap-3 justify-end">
                                        <!-- 详情链接 -->
                                        <a href="${pageContext.request.contextPath}/activity/detail/${activity.id}"
                                           class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm transition-colors">
                                            <i class="fa fa-calendar-check-o mr-1"></i> 查看详情
                                        </a>

                                        <!-- 报名按钮（仅根据status判断） -->
                                        <c:choose>
                                            <c:when test="${activity.status == 1}">
                                                <a href="${pageContext.request.contextPath}/activity/signup/${activity.id}"
                                                   class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                                                    <i class="fa fa-check mr-1"></i> 立即报名
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="bg-gray-300 text-gray-500 px-4 py-2 rounded-lg text-sm cursor-not-allowed">
                                                    <i class="fa fa-clock-o mr-1"></i> 已结束
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty activities}">
                    <div class="bg-white rounded-xl p-6 text-center">
                        <i class="fa fa-calendar-o text-gray-400 text-5xl mb-4"></i>
                        <h3 class="text-xl font-medium text-gray-700 mb-2">暂无活动</h3>
                        <p class="text-gray-500">请稍后再查看或联系管理员发布活动</p>
                    </div>
                </c:if>

                <!-- 分页 -->
                <div class="mt-8 flex justify-center">
                    <nav class="flex items-center space-x-1">
                        <a href="#" class="px-3 py-2 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors">
                            <i class="fa fa-angle-left"></i>
                        </a>
                        <a href="#" class="px-3 py-2 rounded-lg bg-primary text-white">1</a>
                        <a href="#" class="px-3 py-2 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors">2</a>
                        <a href="#" class="px-3 py-2 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors">3</a>
                        <span class="px-3 py-2 text-gray-500">...</span>
                        <a href="#" class="px-3 py-2 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors">10</a>
                        <a href="#" class="px-3 py-2 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors">
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </nav>
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

    // 筛选条件变化时提交表单
    document.querySelectorAll('select').forEach(select => {
        select.addEventListener('change', function() {
            // 实际项目中这里应该提交表单或进行AJAX请求
            console.log('筛选条件变化:', this.value);
        });
    });
</script>
</body>
</html>