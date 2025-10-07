import React, { useEffect } from 'react';
import { Button, Form, Input, Select, message } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { useAppDispatch, useAppSelector } from '../hooks/redux';
import { fetchProjects } from '../store/projectsSlice';
import { createTimeEntry } from '../store/timeEntriesSlice';
import { fetchStats } from '../store/statsSlice';

const { Option } = Select;

export const CreateTimeEntryForm: React.FC = () => {
  const [form] = Form.useForm();
  const dispatch = useAppDispatch();
  const { projects } = useAppSelector((state) => state.projects);
  const [loading, setLoading] = React.useState(false);

  useEffect(() => {
    dispatch(fetchProjects());
  }, [dispatch]);

  const handleSubmit = async (values: { project_id: number; description: string }) => {
    setLoading(true);
    try {
      await dispatch(
        createTimeEntry({
          project_id: values.project_id,
          description: values.description,
          start_time: new Date().toISOString(),
        })
      ).unwrap();

      message.success('Запись времени создана!');
      form.resetFields();
      
      // Обновляем статистику
      dispatch(fetchStats());
    } catch (error) {
      message.error('Ошибка при создании записи');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Form form={form} layout="inline" onFinish={handleSubmit} style={{ marginBottom: 24 }}>
      <Form.Item
        name="project_id"
        rules={[{ required: true, message: 'Выберите проект' }]}
        style={{ minWidth: 200 }}
      >
        <Select placeholder="Выберите проект" style={{ width: '100%' }}>
          {projects.map((project) => (
            <Option key={project.id} value={project.id}>
              <div style={{ display: 'flex', alignItems: 'center' }}>
                <div
                  style={{
                    width: 12,
                    height: 12,
                    borderRadius: '50%',
                    backgroundColor: project.color,
                    marginRight: 8,
                  }}
                />
                {project.name}
              </div>
            </Option>
          ))}
        </Select>
      </Form.Item>

      <Form.Item
        name="description"
        rules={[{ required: true, message: 'Введите описание' }]}
        style={{ minWidth: 300, flex: 1 }}
      >
        <Input placeholder="Что вы делали?" />
      </Form.Item>

      <Form.Item>
        <Button type="primary" htmlType="submit" icon={<PlusOutlined />} loading={loading}>
          Добавить запись
        </Button>
      </Form.Item>
    </Form>
  );
};