const base = {
    get() {
        return {
            url : "http://localhost:8080/nodejs63qva/",
            name: "nodejs63qva",
            // 退出到首页链接
            indexUrl: ''
        };
    },
    getProjectName(){
        return {
            projectName: "民宿管理系统"
        } 
    }
}
export default base
