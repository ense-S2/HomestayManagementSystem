const menu = {
    list() {
        return [
            {
                // 管理员角色菜单
                "backMenu": [
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-goodsnew", // 图标
                                "buttons": ["新增", "查看", "修改", "删除"], // 按钮权限
                                "menu": "用户", // 菜单名称
                                "menuJump": "列表", // 跳转到的页面
                                "tableName": "yonghu" // 关联表名
                            }
                        ],
                        "menu": "用户管理" // 一级菜单名称
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-list",
                                "buttons": ["新增", "查看", "修改", "删除"],
                                "menu": "客房信息",
                                "menuJump": "列表",
                                "tableName": "kefangxinxi"
                            }
                        ],
                        "menu": "客房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-camera",
                                "buttons": ["查看", "删除", "审核"],
                                "menu": "订房信息",
                                "menuJump": "列表",
                                "tableName": "dingfangxinxi"
                            }
                        ],
                        "menu": "订房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-paint",
                                "buttons": ["查看", "删除", "审核"],
                                "menu": "续房信息",
                                "menuJump": "列表",
                                "tableName": "xufangxinxi"
                            }
                        ],
                        "menu": "续房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-paint",
                                "buttons": ["查看", "删除", "审核"],
                                "menu": "换房信息管理",
                                "menuJump": "列表",
                                "tableName": "huanfangxinxi"
                            }
                        ],
                        "menu": "换房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-time",
                                "buttons": ["查看", "删除", "审核", "费用"],
                                "menu": "退房信息",
                                "menuJump": "列表",
                                "tableName": "tuifangxinxi"
                            }
                        ],
                        "menu": "退房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-qrcode",
                                "buttons": ["查看", "修改", "删除"],
                                "menu": "费用信息",
                                "menuJump": "列表",
                                "tableName": "feiyongxinxi"
                            }
                        ],
                        "menu": "费用信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-data", // 新增图标
                                "buttons": ["查看", "统计"], // 按钮权限
                                "menu": "销售情况", // 菜单名称
                                "menuJump": "列表", // 跳转页面
                                "tableName": "xiaoshouqingkuang" // 关联表名
                            }
                        ],
                        "menu": "销售管理" // 一级菜单名称
                    }
                ],
                "frontMenu": [], // 前端菜单为空
                "hasBackLogin": "是", // 后台登录权限
                "hasBackRegister": "否", // 后台注册权限
                "hasFrontLogin": "否", // 前台登录权限
                "hasFrontRegister": "否", // 前台注册权限
                "roleName": "管理员", // 角色名称
                "tableName": "users" // 关联表名
            },
            {
                // 用户角色菜单
                "backMenu": [
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-list",
                                "buttons": ["查看", "订房"],
                                "menu": "客房信息",
                                "menuJump": "列表",
                                "tableName": "kefangxinxi"
                            }
                        ],
                        "menu": "客房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-camera",
                                "buttons": ["查看", "续房", "换房", "退房"],
                                "menu": "订房信息",
                                "menuJump": "列表",
                                "tableName": "dingfangxinxi"
                            }
                        ],
                        "menu": "订房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-paint",
                                "buttons": ["查看", "退房"],
                                "menu": "续房信息",
                                "menuJump": "列表",
                                "tableName": "xufangxinxi"
                            }
                        ],
                        "menu": "续房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-paint",
                                "buttons": ["查看"],
                                "menu": "换房信息",
                                "menuJump": "列表",
                                "tableName": "huanfangxinxi"
                            }
                        ],
                        "menu": "换房信息"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-time",
                                "buttons": ["查看"],
                                "menu": "退房信息",
                                "menuJump": "列表",
                                "tableName": "tuifangxinxi"
                            }
                        ],
                        "menu": "退房信息管理"
                    },
                    {
                        "child": [
                            {
                                "appFrontIcon": "cuIcon-qrcode",
                                "buttons": ["查看", "支付"],
                                "menu": "费用信息",
                                "menuJump": "列表",
                                "tableName": "feiyongxinxi"
                            }
                        ],
                        "menu": "费用信息管理"
                    }
                ],
                "frontMenu": [],
                "hasBackLogin": "是", // 后台登录权限
                "hasBackRegister": "是", // 后台注册权限
                "hasFrontLogin": "否", // 前台登录权限
                "hasFrontRegister": "否", // 前台注册权限
                "roleName": "用户", // 角色名称
                "tableName": "yonghu" // 关联表名
            }
        ];
    }
};

export default menu;
