import { Router } from 'express'	//路由实现单独的逻辑
import { Op } from 'sequelize'		//数据库操作集合
import toRes from '../lib/toRes'	//格式化返回http响应
import ConfigModel from '../models/ConfigModel'

export default ({ config, db }) => {
	let api = Router()

	// 分页接口（后端）
	api.get('/page', async (req, res) => {		//url路径是page、异步请求

		try {
			//解析分页参数
			let page = parseInt(req.query.page) || 1
			let limit = parseInt(req.query.limit) || 10
			let sort = req.query.sort || 'id'
			let order = req.query.order || 'asc'
			
			//构造查询条件
			let where = {}
			let name = req.query.name
			if (name) {
				where.name = {
					[Op.like]: '%' + name + '%'		//模糊匹配
				}
			}

			//查询
			let result = await ConfigModel.findAndCountAll({
				order: [[sort, order]],		//排序
				where,						//条件
				offset: (page - 1) * limit, //偏移量
				limit						//每页数量
			})
			
			//分页信息
			result.currPage = page
			result.pageSize = limit

			//返回查询的分页信息
			toRes.page(res, 0, result)
		} catch(err) {
			
			toRes.session(res, 500, '服务器错误！', '', 500)
		}
	})

	// 分页接口（前端）
	api.get('/list', async (req, res) => {

		try {

			let page = parseInt(req.query.page) || 1
			let limit = parseInt(req.query.limit) || 10
			let sort = req.query.sort || 'id'
			let order = req.query.order || 'asc'

			let where = {}

			let name = req.query.name
			if (name) {
				where.name = {
					[Op.like]: '%' + name + '%'
				}
			}

			let result = await ConfigModel.findAndCountAll({
				order: [[sort, order]],
				where,
				offset: (page - 1) * limit,
				limit
			})
			
			result.currPage = page
			result.pageSize = limit

			toRes.page(res, 0, result)
		} catch(err) {
			
			toRes.session(res, 500, '服务器错误！', '', 500)
		}
	})

	//更新接口，通过id主键定位并修改
	api.post('/update', async (req, res) => {

		try {

			await ConfigModel.update(req.body, {
				where: {
				  id: req.body.id
				}
			})

			toRes.session(res, 0, '编辑成功！')
		} catch(err) {
			
			toRes.session(res, 500, '服务器错误！', '', 500)
		}
	})

	// 详情接口
	api.get('/info/:id', async (req, res) => {

		try {

			toRes.record(res, 0, await ConfigModel.findOne({ where: { id: req.params.id } }))
		} catch(err) {

			toRes.session(res, 500, '服务器错误！', '', 500)
		}
	})

	// 配置获取接口（后端）
	api.get('/info', async (req, res) => {

		try {

			toRes.record(res, 0, await ConfigModel.findOne({ where: { name: req.query.name } }))
		} catch(err) {

			toRes.session(res, 500, '服务器错误！', '', 500)
		}
	})

	// 配置获取接口（前端）
	api.get('/detail', async (req, res) => {

		try {

			toRes.record(res, 0, await ConfigModel.findOne({ where: { name: req.query.name } }))
		} catch(err) {

			toRes.session(res, 500, '服务器错误！', '', 500)
		}
	})

	return api
}
