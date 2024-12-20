import { Sequelize, DataTypes } from 'sequelize'
import moment from 'moment'
import sequelize from './sequelize'

// 客房信息
const KefangxinxiModel = sequelize.define('KefangxinxiModel', {
	id: {
		type: DataTypes.BIGINT,
		primaryKey: true,
		autoIncrement: true,
		allowNull: false,
		comment: '主键id'
	},
	kefangbianhao: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房编号'
	},
	kefangleixing: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房类型'
	},
	kefangweizhi: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房位置'
	},
	kefangzhuangtai: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房状态'
	},
	kefangjiage: {
		type: DataTypes.INTEGER,
		defaultValue: 0,
		allowNull: true,
		comment: '客房价格'
	},
	kefangjieshao: {
		type: DataTypes.TEXT,
		defaultValue: '',
		allowNull: true,
		comment: '客房介绍'
	},
	kefangtupian: {
		type: DataTypes.STRING,
		defaultValue: '',
		allowNull: true,
		comment: '客房图片'
	},
	addtime: {
  		type: DataTypes.DATE,
  		defaultValue: DataTypes.NOW,
    	allowNull: false,
    	get() {
            return moment(this.getDataValue('addtime')).format('YYYY-MM-DD HH:mm:ss')
        },
		comment: '添加时间'
	}
}, {
	timestamps: false,
	freezeTableName: true,
	tableName: 'kefangxinxi'
})

export default KefangxinxiModel
