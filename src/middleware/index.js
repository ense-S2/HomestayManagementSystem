import { Router } from 'express';

export default ({ config, db }) => {
	let routes = Router();

	// add middleware here
	//可插入日志记录、权限认证、错误处理、请求预处理等中间件功能

	return routes;
}
