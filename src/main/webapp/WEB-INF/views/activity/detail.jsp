<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${activity.title} - 社团管理系统</title>
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
                        <button class="p-2 rounded-full hover:bg-gray-100">
                            <i class="fa fa-arrow-left text-gray-600" onclick="history.back()"></i>
                        </button>
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
            <c:if test="${empty activity}">
                <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded-r" role="alert">
                    <div class="flex">
                        <div class="py-1"><i class="fa fa-exclamation-circle text-red-500 mr-3"></i></div>
                        <div>
                            <p class="font-bold">错误</p>
                            <p>活动不存在或已被删除</p>
                        </div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/activity/list" class="inline-flex items-center px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors shadow-sm">
                    <i class="fa fa-arrow-left mr-2"></i> 返回活动列表
                </a>
            </c:if>

            <c:if test="${not empty activity}">
                <div class="mb-6">
                    <nav class="flex" aria-label="面包屑">
                        <ol class="inline-flex items-center space-x-1 md:space-x-3">
                            <li class="inline-flex items-center">
                                <a href="${pageContext.request.contextPath}/student/me" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-primary">
                                    <i class="fa fa-home mr-2"></i>首页
                                </a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <i class="fa fa-angle-right text-gray-400 mx-2"></i>
                                    <a href="${pageContext.request.contextPath}/activity/list" class="text-sm font-medium text-gray-500 hover:text-primary">活动列表</a>
                                </div>
                            </li>
                            <li aria-current="page">
                                <div class="flex items-center">
                                    <i class="fa fa-angle-right text-gray-400 mx-2"></i>
                                    <span class="text-sm font-medium text-gray-700">${activity.title}</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <!-- 活动详情卡片 -->
                <div class="bg-white rounded-xl overflow-hidden card-shadow mb-6">
                    <div class="relative h-64 md:h-80">
                        <!-- 活动封面图 -->
                        <c:choose>
                            <c:when test="${activity.id == 1}">
                                <img src="https://picsum.photos/id/1025/1200/400" alt="校园文化节" class="w-full h-full object-cover">
                            </c:when>
                            <c:when test="${activity.id == 2}">
                                <img src="https://picsum.photos/id/1012/1200/400" alt="校园歌手大赛" class="w-full h-full object-cover">
                            </c:when>
                            <c:when test="${activity.id == 3}">
                                <img src="https://picsum.photos/id/1062/1200/400" alt="羽毛球淘汰赛" class="w-full h-full object-cover">
                            </c:when>
                            <c:otherwise>
                                <img src="https://picsum.photos/id/100/1200/400" alt="默认活动图片" class="w-full h-full object-cover">
                            </c:otherwise>
                        </c:choose>

                        <!-- 活动状态标签 -->
                        <c:set var="currentTime" value="<%= LocalDateTime.now() %>" />
                        <c:choose>
                            <c:when test="${activity.status == 1}">
                                <div class="absolute top-4 left-4 bg-white rounded-full px-4 py-2 text-sm font-medium text-green-600">
                                    进行中
                                </div>
                            </c:when>
                            <c:when test="${activity.startTime.isAfter(currentTime)}">
                                <div class="absolute top-4 left-4 bg-white rounded-full px-4 py-2 text-sm font-medium text-blue-600">
                                    即将开始
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="absolute top-4 left-4 bg-white rounded-full px-4 py-2 text-sm font-medium text-gray-600">
                                    已结束
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- 分享按钮 -->
                        <div class="absolute top-4 right-4 bg-white rounded-full p-2 text-gray-600 hover:text-primary cursor-pointer">
                            <i class="fa fa-share-alt"></i>
                        </div>

                        <!-- 收藏按钮 -->
                        <div class="absolute top-4 right-16 bg-white rounded-full p-2 text-gray-600 hover:text-primary cursor-pointer">
                            <i class="fa fa-heart-o"></i>
                        </div>
                    </div>

                    <div class="p-6">
                        <div class="flex justify-between items-start mb-4">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800 mb-2">${activity.title}</h1>
                                <div class="flex items-center mb-4">
                                    <!-- 社团信息 -->
                                    <c:choose>
                                        <c:when test="${activity.clubId == 1}">
                                            <img src="https://picsum.photos/id/1025/40/40" alt="文化社团" class="w-8 h-8 rounded-full mr-2">
                                            <div>
                                                <p class="font-medium text-gray-800">文化社团</p>
                                                <p class="text-xs text-gray-500">主办方</p>
                                            </div>
                                        </c:when>
                                        <c:when test="${activity.clubId == 2}">
                                            <img src="https://picsum.photos/id/1012/40/40" alt="音乐社团" class="w-8 h-8 rounded-full mr-2">
                                            <div>
                                                <p class="font-medium text-gray-800">音乐社团</p>
                                                <p class="text-xs text-gray-500">主办方</p>
                                            </div>
                                        </c:when>
                                        <c:when test="${activity.clubId == 3}">
                                            <img src="https://picsum.photos/id/1062/40/40" alt="体育社团" class="w-8 h-8 rounded-full mr-2">
                                            <div>
                                                <p class="font-medium text-gray-800">体育社团</p>
                                                <p class="text-xs text-gray-500">主办方</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://picsum.photos/id/100/40/40" alt="默认社团" class="w-8 h-8 rounded-full mr-2">
                                            <div>
                                                <p class="font-medium text-gray-800">未知社团</p>
                                                <p class="text-xs text-gray-500">主办方</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <!-- 活动ID -->
                            <div class="bg-gray-100 rounded-lg p-2">
                                <p class="text-xs text-gray-500">活动编号</p>
                                <p class="font-medium text-gray-800">AC-${activity.id}</p>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                            <div class="bg-gray-50 rounded-lg p-4">
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center mr-3 flex-shrink-0">
                                        <i class="fa fa-calendar text-primary"></i>
                                    </div>
                                    <div>
                                        <h3 class="font-medium text-gray-800">活动时间</h3>
                                        <p class="text-gray-600 text-sm">
                                            <c:set var="formatter" value="<%= DateTimeFormatter.ofPattern(\"yyyy-MM-dd HH:mm\") %>" />
                                                ${formatter.format(activity.startTime)}
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-gray-50 rounded-lg p-4">
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center mr-3 flex-shrink-0">
                                        <i class="fa fa-map-marker text-secondary"></i>
                                    </div>
                                    <div>
                                        <h3 class="font-medium text-gray-800">活动地点</h3>
                                        <p class="text-gray-600 text-sm">${activity.location}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-gray-50 rounded-lg p-4">
                                <div class="flex items-start">
                                    <div class="w-10 h-10 rounded-full bg-purple-100 flex items-center justify-center mr-3 flex-shrink-0">
                                        <i class="fa fa-users text-accent"></i>
                                    </div>
                                    <div>
                                        <h3 class="font-medium text-gray-800">参与人数</h3>
                                        <p class="text-gray-600 text-sm">
                                            <i class="fa fa-users mr-1"></i> ${activityService.countSignup(activity.id)} 人已报名
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 活动详情 -->
                        <div class="mb-6">
                            <h2 class="text-xl font-bold text-gray-800 mb-4">活动详情</h2>
                            <div class="prose max-w-none">
                                <c:choose>
                                    <c:when test="${activity.id == 1}">
                                        <p>校园文化节是我校一年一度的综合性文化活动，旨在丰富校园文化生活，促进学生全面发展。</p>
                                        <p>本次文化节将包括文艺表演、传统文化展示、手工制作、美食体验等多个环节，欢迎全校师生积极参与。</p>
                                        <p>活动时间：${formatter.format(activity.startTime)}</p>
                                        <p>活动地点：体育馆</p>
                                        <p>参与方式：免费入场，部分活动需要提前报名</p>
                                    </c:when>
                                    <c:when test="${activity.id == 2}">
                                        <p>校园歌手大赛是我校最具影响力的音乐赛事之一，旨在发掘校园音乐人才，为热爱音乐的同学提供展示平台。</p>
                                        <p>本次大赛分为初赛、复赛和决赛三个阶段，邀请专业音乐老师担任评委，优胜者将有机会代表学校参加全国校园歌手大赛。</p>
                                        <p>活动时间：${formatter.format(activity.startTime)}</p>
                                        <p>活动地点：音乐馆</p>
                                        <p>参与方式：线上报名，通过选拔即可参赛</p>
                                    </c:when>
                                    <c:when test="${activity.id == 3}">
                                        <p>羽毛球淘汰赛是我校体育社团主办的一项体育赛事，旨在促进学生身心健康，提高羽毛球水平。</p>
                                        <p>本次比赛分为男子单打、女子单打和混合双打三个项目，采用单淘汰制，决出冠亚季军。</p>
                                        <p>活动时间：${formatter.format(activity.startTime)}</p>
                                        <p>活动地点：羽毛球馆</p>
                                        <p>参与方式：校内学生均可报名，报名费每人20元</p>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>

                        <!-- 活动日程 -->
                        <c:choose>
                            <c:when test="${activity.id == 1}">
                                <div class="mb-6">
                                    <h2 class="text-xl font-bold text-gray-800 mb-4">活动日程</h2>
                                    <div class="space-y-4">
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">09:00</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">开幕式</span>
                                            </div>
                                        </div>
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">10:00</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">文艺表演</span>
                                            </div>
                                        </div>
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">13:30</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">传统文化展示</span>
                                            </div>
                                        </div>
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">15:00</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">手工制作体验</span>
                                            </div>
                                        </div>
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">17:00</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">闭幕式</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${activity.id == 2}">
                                <div class="mb-6">
                                    <h2 class="text-xl font-bold text-gray-800 mb-4">比赛流程</h2>
                                    <div class="space-y-4">
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">18:30</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">选手签到</span>
                                            </div>
                                        </div>
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">19:00</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">比赛开始</span>
                                            </div>
                                        </div>
                                        <div class="flex">
                                            <div class="w-20 text-right pr-4">
                                                <span class="text-sm font-medium text-gray-500">21:00</span>
                                            </div>
                                            <div class="flex-1">
                                                <div class="h-px bg-gray-200 my-2"></div>
                                            </div>
                                            <div class="w-20 pl-4">
                                                <span class="text-sm font-medium text-gray-800">颁奖环节</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${activity.id == 3}">
                                <div class="mb-6">
                                    <h2 class="text-xl font-bold text-gray-800 mb-4">比赛规则</h2>
                                    <div class="prose max-w-none">
                                        <p>1. 比赛采用单淘汰制，三局两胜制，每局21分。</p>
                                        <p>2. 参赛选手需提前30分钟到场签到，迟到15分钟视为弃权。</p>
                                        <p>3. 比赛使用YONEX AS-50羽毛球，球拍自备。</p>
                                        <p>4. 尊重裁判判罚，如有异议可向组委会申诉。</p>
                                        <p>5. 保持赛场整洁，爱护场馆设施。</p>
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>

                        <!-- 按钮组 -->
                        <div class="flex flex-wrap gap-3 justify-end">
                            <!-- 分享按钮 -->
                            <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm transition-colors flex items-center">
                                <i class="fa fa-share-alt mr-1"></i> 分享活动
                            </button>

                            <!-- 返回按钮 -->
                            <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm transition-colors flex items-center" onclick="history.back()">
                                <i class="fa fa-arrow-left mr-1"></i> 返回
                            </button>

                            <!-- 报名按钮：根据活动状态判断 -->
                            <c:choose>
                                <c:when test="${activity.status == 0}">
                                    <!-- 已取消的活动 -->
                                    <button class="bg-gray-300 text-gray-500 px-4 py-2 rounded-lg text-sm cursor-not-allowed">
                                        <i class="fa fa-ban mr-1"></i> 已取消
                                    </button>
                                </c:when>
                                <c:when test="${activity.startTime.isBefore(currentTime)}">
                                    <!-- 已结束的活动 -->
                                    <button class="bg-gray-300 text-gray-500 px-4 py-2 rounded-lg text-sm cursor-not-allowed">
                                        <i class="fa fa-clock-o mr-1"></i> 已结束
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <!-- 可报名的活动 -->
                                    <a href="${pageContext.request.contextPath}/activity/signup/${activity.id}"
                                       class="bg-primary hover:bg-primary/90 text-white px-6 py-2 rounded-lg text-sm transition-colors flex items-center">
                                        <i class="fa fa-check mr-1"></i> 立即报名
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- 相关活动 -->
                <div class="mb-6">
                    <h2 class="text-xl font-bold text-gray-800 mb-4">相关活动</h2>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <!-- 这里可以展示其他相关活动 -->
                        <c:forEach var="relatedActivity" items="${activities}" varStatus="status">
                            <c:if test="${relatedActivity.id != activity.id && status.index < 3}">
                                <div class="bg-white rounded-xl overflow-hidden card-shadow hover:shadow-lg transition-shadow">
                                    <div class="relative h-40">
                                        <c:choose>
                                            <c:when test="${relatedActivity.id == 1}">
                                                <img src="https://picsum.photos/id/1025/600/400" alt="校园文化节" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:when test="${relatedActivity.id == 2}">
                                                <img src="https://picsum.photos/id/1012/600/400" alt="校园歌手大赛" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:when test="${relatedActivity.id == 3}">
                                                <img src="https://picsum.photos/id/1062/600/400" alt="羽毛球淘汰赛" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://picsum.photos/id/100/600/400" alt="默认活动图片" class="w-full h-full object-cover">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="p-4">
                                        <h3 class="font-bold text-gray-800 mb-2">${relatedActivity.title}</h3>
                                        <div class="flex items-center text-sm text-gray-600 mb-3">
                                            <i class="fa fa-calendar-o mr-1"></i>
                                                ${formatter.format(relatedActivity.startTime)}
                                        </div>
                                        <div class="flex items-center text-sm text-gray-600 mb-3">
                                            <i class="fa fa-map-marker mr-1"></i>
                                                ${relatedActivity.location}
                                        </div>
                                        <a href="${pageContext.request.contextPath}/activity/detail/${relatedActivity.id}" class="text-primary hover:text-primary/80 text-sm font-medium">
                                            查看详情 <i class="fa fa-angle-right ml-1"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
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

    // 报名确认
    function confirmSignup() {
        if (confirm('确定要报名参加此活动吗？')) {
            // 调用后端报名接口
            window.location.href = "${pageContext.request.contextPath}/activity/signup/${activity.id}";
        }
    }
</script>
</body>
</html>