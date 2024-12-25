import { Router } from 'express';
import DingfangxinxiModel from '../models/DingfangxinxiModel'; // 确保路径正确
import { Op } from 'sequelize';
import toRes from '../lib/toRes'; // 确保路径正确

const router = Router();

// 时间区间筛选接口
router.get('/filter', async (req, res) => {
    try {
        const { startTime, endTime } = req.query;

        if (!startTime || !endTime) {
            console.error("Missing startTime or endTime");
            return toRes.session(res, 400, '请提供起始时间和结束时间');
        }

        const orders = await DingfangxinxiModel.findAll({
            where: {
                ruzhushijian: {
                    [Op.between]: [startTime, endTime]
                }
            }
        });

        toRes.list(res, 0, orders);
    } catch (err) {
        console.error('Filter Error:', err);
        toRes.session(res, 500, '服务器错误！');
    }
});

// 数据统计接口
router.get('/stats', async (req, res) => {
    try {
        const { startTime, endTime } = req.query;

        if (!startTime || !endTime) {
            console.error("Missing startTime or endTime");
            return toRes.session(res, 400, '请提供起始时间和结束时间');
        }

        // 获取数据
        const orders = await DingfangxinxiModel.findAll({
            where: {
                ruzhushijian: {
                    [Op.between]: [startTime, endTime]
                }
            },
            attributes: ['kefangbianhao', 'kefangleixing', 'kefangjiage', 'ruzhushijian'] // 返回指定字段
        });

        // 格式化数据以符合前端需求
        const salesStats = orders.map(order => ({
            kefangbianhao: order.kefangbianhao,
            kefangleixing: order.kefangleixing,
            salesAmount: order.kefangjiage,
            ruzhushijian: order.ruzhushijian
        }));

        // 返回数据
        toRes.record(res, 200, { salesStats }, "订单数据获取成功");
    } catch (err) {
        console.error('Stats Error:', err.stack);
        toRes.session(res, 500, '服务器错误！');
    }
});

export default router;
